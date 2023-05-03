//
//  SignInModel.swift
//  SignIn
//
//  Created by Nitin on 5/3/23.
//

import Foundation

struct SignInModel {
    
    // text field values
    var emailTextFieldValue: String = ""
    var passwordTextFieldValue: String = ""
    var confirmPasswordTextFieldValue: String = ""
    
    // validation messages
    var emailValidationMessage: String = ""
    var passwordValidationMessage: String = ""
    var confirmPasswordValidationMessage: String = ""
    
    // visibility for password and confirm password
    var isConfirmPasswordVisible: Bool = false
    var isPasswordVisible: Bool = false
    
    
    mutating func resetValues() {
        emailTextFieldValue = ""
        passwordTextFieldValue = ""
        confirmPasswordTextFieldValue = ""
        
        emailValidationMessage = ""
        passwordValidationMessage = ""
        confirmPasswordValidationMessage = ""
        
        isConfirmPasswordVisible = false
        isPasswordVisible = false
    }
    
    mutating func checkForValidations(textFieldValidate: TextFieldValidations, isNewUser: Bool) {
        // check for validations
        // if any field is left empty
        emailValidationMessage = textFieldValidate.checkEmptyTextFields(text: emailTextFieldValue) ?? emailValidationMessage
        passwordValidationMessage = textFieldValidate.checkEmptyTextFields(text: passwordTextFieldValue) ?? passwordValidationMessage
        
        // if new user check for confirm password
        if isNewUser {
            confirmPasswordValidationMessage = textFieldValidate.checkEmptyTextFields(text: confirmPasswordTextFieldValue) ?? confirmPasswordValidationMessage
        }
    }
    
    func checkForValidationMessages(textFieldValidate: TextFieldValidations) -> Bool {
        return textFieldValidate.checkIfValidationMessageIsEmpty(
            [emailValidationMessage, passwordValidationMessage, confirmPasswordValidationMessage]
        )
    }
    
    func getData() -> [String : Any] {
        return [
            Constants.keyEmail : emailTextFieldValue,
            Constants.keyPassword : passwordTextFieldValue
        ]
    }
}
