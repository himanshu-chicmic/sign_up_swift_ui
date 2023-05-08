//
//  PasswordTextField.swift
//  SignIn
//
//  Created by Himanshu on 5/2/23.
//

import SwiftUI


/// view for creating password text fields
/// with show/hide password functions
struct PasswordTextField: View {
    
    // MARK: properties
    
    // observed object for viewModelBase class
    @ObservedObject var viewModelBase: ViewModelBase
    
    // binding varialble for signInModel
    @Binding var signInModel: SignInModel
    
    // placeholder for text field
    var placeholder: String
    
    // binding var for textfield value
    @Binding var textFieldValue: String
    
    // password (original or confirm)
    var toMatchWithPassword: String
     
    // property to get the icon based of the bool val of isPasswordVisible
    var passwordVisibilityIcon: String {
        isPasswordVisible ? Constants.DefaultIcons.passwordVisible : Constants.DefaultIcons.passwordHidden
    }
    
    // binding variable for password visibility
    @Binding var isPasswordVisible: Bool
    
    // MARK: body
    
    var body: some View {
        VStack{
            HStack{
                // if password is in visible mode show
                // as normal text field
                if isPasswordVisible {
                    TextField(placeholder, text: $textFieldValue)
                }
                // else show as a secure text field
                else {
                    SecureField(placeholder, text: $textFieldValue)
                }
                  
                // password toggle button
                Button(action: {
                    isPasswordVisible.toggle()
                }, label: {
                    Image(systemName: passwordVisibilityIcon)
                })
            }
            .font(.system(size: 14))
            .padding()
            .frame(height: 52)
            .background(.gray.opacity(0.25))
            .cornerRadius(6)
            .onChange(of: textFieldValue){
                text in
                // check if user is new
                // we don't need password validation during login
                if viewModelBase.isNewUser {
                    withAnimation{
                        
                        // for password validation message
                        if placeholder != Constants.Placeholder.confirmPassword {
                            signInModel.passwordValidationMessage = viewModelBase
                                .textFieldValidate
                                .validateEmailPassword(
                                    value:  text,
                                    flag:   true
                                )
                        }
                        // for confirm password validation message
                        // if password is confirm password
                        // send toMatchPassword as original
                        // else send toMatchPassword as confirm password
                        
                        signInModel
                            .confirmPasswordValidationMessage = (placeholder == Constants.Placeholder.confirmPassword)
                            // when user types confirm password
                            // then show error in confirm password validation
                            // by matching with original password
                            ? viewModelBase
                                .textFieldValidate
                                .validateConfirmPassword(
                                    originalPassword:   toMatchWithPassword,
                                    confirmPassword:    text)
                            // when confirm password is not empty
                            // and user tries to change original password
                            // then show error in confirm password validation
                            // by matching the orignal password with confirm password
                            : viewModelBase
                                .textFieldValidate
                                .validateConfirmPassword(
                                    originalPassword:   text,
                                    confirmPassword:    toMatchWithPassword)
                    }
                }
            }
        }
    }
}
