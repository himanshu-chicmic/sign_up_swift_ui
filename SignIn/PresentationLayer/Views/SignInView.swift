//
//  SignInView.swift
//  SignIn
//
//  Created by Himanshu on 5/1/23.
//

import SwiftUI

struct SignInView: View {
    
    // MARK: properties
    
    // model class for signin properties
    @State var signInModel = SignInModel()
    
    // environment object for signin viewmodel
    @EnvironmentObject private var signInViewModel: SignInViewModel 
    
    // check if user is new or existing
    // this bool is used to show signup or login
    // if true show singup else show login
    // by default this var is true
    @State var isNewUser: Bool = true {
        // when the value of new user is changed
        // reset all values of text fields and other bool
        // used with them
        didSet {
            signInModel.resetValues()
        }
    }
    
    // property to get type of signin (heading/title)
    var signInType: String {
        isNewUser ? Constants.signUp : Constants.logIn
    }
    
    // propert to get signIn caption (subheading)
    var signInCaption: String {
        isNewUser ? Constants.signInTitleCaption1 : Constants.signInTitleCaption2
    }
    
    // get signin button text
    var signInButtonText: String {
        isNewUser ? Constants.signUpButtonText : Constants.loginButtonText
    }
    
    // get a string for have or do not have an account
    var haveAnAccount: String {
        isNewUser ? Constants.alreadyHaveAnAccount : Constants.dontHaveAnAccount
    }
    
    // instance of TextFieldValidations
    private let textFieldValidate = TextFieldValidations()
    
    var body: some View {
        ScrollView {
            VStack{
                
                TitleAndCaption(title: signInType, caption: signInCaption)
                
                Group{
                    DefaultTextField(placeholder: Constants.emailAddress, textFieldValue: $signInModel.emailTextFieldValue)
                        .keyboardType(.emailAddress)
                        .onChange(of: signInModel.emailTextFieldValue){
                            text in
                            withAnimation{
                                signInModel.emailValidationMessage = textFieldValidate.validateEmailPassword(value: text, flag: false)
                            }
                        }
                    
                    ValidationMessage(validationMessage: $signInModel.emailValidationMessage)
                    
                    
                    PasswordTextField(textFieldValue: $signInModel.passwordTextFieldValue, placeholder: Constants.password, originalPassword: signInModel.confirmPasswordTextFieldValue, isPasswordVisible: $signInModel.isPasswordVisible, passwordValidationMessage: $signInModel.passwordValidationMessage, confirmPasswordValidationMessage: $signInModel.confirmPasswordValidationMessage)
                    
                    ValidationMessage(validationMessage: $signInModel.passwordValidationMessage)
                    
                    if isNewUser {
                        
                        PasswordTextField(textFieldValue: $signInModel.confirmPasswordTextFieldValue, placeholder: Constants.confirmPassword, originalPassword: signInModel.passwordTextFieldValue, isPasswordVisible: $signInModel.isConfirmPasswordVisible, passwordValidationMessage: $signInModel.passwordValidationMessage, confirmPasswordValidationMessage: $signInModel.confirmPasswordValidationMessage)
                        
                        ValidationMessage(validationMessage: $signInModel.confirmPasswordValidationMessage)
                            .onAppear{
                                signInModel.confirmPasswordValidationMessage = ""
                            }
                    }
                }
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                
                Button(action: {
                    
                    signInModel.checkForValidations(textFieldValidate: textFieldValidate, isNewUser: isNewUser)
                    
                    // check if validation messages are empty
                    if (
                        signInModel.checkForValidationMessages(textFieldValidate: textFieldValidate)
                    ){
                        
                        // check the request type
                        let requestType = isNewUser ? RequestType.signUp : RequestType.signIn
                        // create a data dictionary
                        let data = signInModel.getData()
                        
                        // call the sendApiRequest method
                        signInViewModel.sendApiRequest(requestType: requestType, data: data)
                    }
                }, label: {
                    ButtonLabel(buttonText: signInButtonText)
                })
                .padding(.vertical, 24)
                
                
                HStack(spacing: 4){
                    
                    Text(haveAnAccount)
                    
                    Button(action: {
                        withAnimation{
                            isNewUser.toggle()
                        }
                    }, label: {
                        Text(isNewUser ? Constants.logIn : Constants.signUp)
                            .fontWeight(.semibold)
                    })
                }
                .font(.system(size: 13))
                
                
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .alert(signInViewModel.errorMessage, isPresented: $signInViewModel.showErrorAlert) {
                Button(Constants.okay, role: .cancel) {
                        signInViewModel.showErrorAlert = false
                        signInViewModel.errorMessage = ""
                }
            }
            .onAppear{
                signInModel.resetValues()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
