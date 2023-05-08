//
//  SignInView.swift
//  SignIn
//
//  Created by Himanshu on 5/1/23.
//

import SwiftUI

struct SignInView: View {
    
    // MARK: properties
    
    // environment object for signin viewmodel
    @EnvironmentObject private var viewModelObj: ViewModelBase 

    // model class for signin properties
    @State var signInModel = SignInModel() {
        didSet{
            // set the value of signInModel
            // in view model's signInModel instance
            // equal to this view's instance
            viewModelObj.signInModel = signInModel
        }
    }
    
    // check if user is new or existing
    // this bool is used to show signup or login
    // if true show singup else show login
    // by default this var is true
    @State var isNewUser: Bool = true {
        // when the value of new user is changed
        // reset all values of text fields and other bool
        // used with them
        didSet {
            
            // reset the text field values
            signInModel = .init()

            //set value in sign in view model
            viewModelObj.isNewUser = isNewUser
        }
    }
    
    
    // MARK: body
    
    var body: some View {
        
        ScrollView {
        
            VStack{
                
                // title and caption
                TitleAndCaption(
                    title:      viewModelObj.signInType,
                    caption:    viewModelObj.signInCaption
                )
                
                // text and password fields
                
                // email address
                TextFieldAndValidationDrawer(
                    placeholder:        Constants.Placeholder.email,
                    textFieldValue:     $signInModel.emailTextFieldValue,
                    valitaionMessage:   $signInModel.emailValidationMessage
                )
                .keyboardType(.emailAddress)
                .onChange(of: signInModel.emailTextFieldValue)
                {
                    text in
                    withAnimation{
                        signInModel.emailValidationMessage = viewModelObj
                            .textFieldValidate
                            .validateEmailPassword(
                                value:  text,
                                flag:   false
                            )
                    }
                }
                
                // password
                PasswordFieldAndValidation(
                    viewModelBaseObj:    viewModelObj,
                    signInModel:        $signInModel,
                    placeholder:        Constants.Placeholder.password
                )

                // confirm password
                if isNewUser {
                    PasswordFieldAndValidation(
                        viewModelBaseObj:    viewModelObj,
                        signInModel:        $signInModel,
                        placeholder:        Constants.Placeholder.confirmPassword
                    )
                }
                
                // signin button
                Button(action: {
                    
                    // check for text field validations
                    signInModel.checkForValidations(
                        textFieldValidate:  viewModelObj.textFieldValidate,
                        isNewUser:          isNewUser
                    )
                    
                    // check if validation messages are empty
                    let checkValidations: Bool = signInModel.checkForValidationMessages(
                        textFieldValidate: viewModelObj.textFieldValidate
                    )
                    
                    // if true call the api
                    if (checkValidations){
                        // call the sendApiRequest method
                        viewModelObj
                            .sendApiRequest(
                                requestType: isNewUser ? .signUp : .signIn
                            )
                    }
                    
                }, label: {
                    // button text
                    ButtonLabel(buttonText: viewModelObj.signInButtonText)
                })
                .padding(.vertical, 24)
                
                
                // bottom option for
                // changing to signin view
                // if user already have an account
                // or back to signup if
                // user doen't have an account
                HStack(spacing: 4){
                    
                    // already / don't have an account text
                    Text(viewModelObj.haveAnAccount)
                    
                    // button
                    Button(action: {
                        // change to login/signup view with isNewUser toggle (false/true)
                        withAnimation{
                            isNewUser.toggle()
                        }
                    }, label: {
                        // set the Sign Up or Log In text on the clickable button
                        Text(isNewUser ? Constants.TextButton.signUp : Constants.TextButton.logIn)
                            .fontWeight(.semibold)
                    })
                }
                .font(.system(size: 13))
                
                
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            // show user alert if any error has encountered
            .alert(viewModelObj.errorMessage, isPresented: $viewModelObj.showErrorAlert) {
                Button(Constants.TextButton.okay, role: .cancel) {
                    viewModelObj.disableErrorMessage()
                }
            }
            .onAppear{
                // reset the text field and validation values when the view appears
                signInModel = .init()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(ViewModelBase())
    }
}
