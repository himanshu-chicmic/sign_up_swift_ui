//
//  PasswordTextField.swift
//  SignIn
//
//  Created by Himanshu on 5/2/23.
//

import SwiftUI

struct PasswordTextField: View {
    
    // MARK: properties
    
    // instance for textFieldValidations
    private let textFieldValidate = TextFieldValidations()
    
    // binding var for textfield value
    @Binding var textFieldValue: String
    // placeholder for text field
    var placeholder: String
    // password (original or confirm)
    var originalPassword: String
    
    // binding variable for password visibility (secure or text)
    @Binding var isPasswordVisible: Bool
    
    // property to get the icon based of the bool val of isPasswordVisible
    var passwordVisibilityIcon: String {
        isPasswordVisible ? Constants.passwordVisible : Constants.passwordHidden
    }
    
    // binding variables for password and confirm password validations
    @Binding var passwordValidationMessage: String
    @Binding var confirmPasswordValidationMessage: String
    
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
                withAnimation{
                    // calling validation methods
                    
                    // for password validation message
                    if placeholder != Constants.confirmPassword {
                        passwordValidationMessage = textFieldValidate.validateEmailPassword(value: text, flag: true)
                    }
                    // for confirm password validation message
                    confirmPasswordValidationMessage = (placeholder == Constants.confirmPassword) ? textFieldValidate.validateConfirmPassword(originalPassword: originalPassword, confirmPassword: text) : textFieldValidate.validateConfirmPassword(originalPassword: text, confirmPassword: originalPassword)
                }
            }
        }
    }
}
