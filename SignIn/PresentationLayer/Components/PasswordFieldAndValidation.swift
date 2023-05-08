//
//  PasswordFieldAndValidation.swift
//  SignIn
//
//  Created by Himanshu on 5/8/23.
//

import SwiftUI

/// view for drawing/creating password field and validation
/// views together
struct PasswordFieldAndValidation: View {
    
    // MARK: properties
    
    // observed object for viewModelBase
    @ObservedObject var viewModelBaseObj: ViewModelBase
    
    // binding var for signInModel
    @Binding var signInModel: SignInModel
    
    // placeholder for text fields
    var placeholder: String
    
    // bool for isConfirmPassword
    // send values to next view according
    // to this bool value
    var isConfirmPassword: Bool {
        placeholder == Constants.Placeholder.password ? false : true
    }
    
    var body: some View {
        VStack{
            // password field
            PasswordTextField(
                viewModelBase:          viewModelBaseObj,
                signInModel:            $signInModel,
                placeholder:            placeholder,
                textFieldValue:         !isConfirmPassword
                                        ? $signInModel.passwordTextFieldValue
                                        : $signInModel.confirmPasswordTextFieldValue,
                toMatchWithPassword:    !isConfirmPassword
                                        ? signInModel.confirmPasswordTextFieldValue
                                        : signInModel.passwordTextFieldValue,
                isPasswordVisible:      !isConfirmPassword
                                        ? $signInModel.isPasswordVisible
                                        : $signInModel.isConfirmPasswordVisible)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)

            // validation message
            ValidationMessage(validationMessage: !isConfirmPassword ? $signInModel.passwordValidationMessage : $signInModel.confirmPasswordValidationMessage)
        }
    }
}
