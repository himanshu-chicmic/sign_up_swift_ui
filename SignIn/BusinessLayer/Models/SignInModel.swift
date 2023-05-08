//
//  SignInModel.swift
//  SignIn
//
//  Created by Himanshu on 5/3/23.
//

import Foundation

struct SignInModel {
    
    // text field values
    var emailTextFieldValue: String
    var passwordTextFieldValue: String
    var confirmPasswordTextFieldValue: String
    
    // validation messages
    var emailValidationMessage: String
    var passwordValidationMessage: String
    var confirmPasswordValidationMessage: String
    
    // visibility for password and confirm password
    var isConfirmPasswordVisible: Bool
    var isPasswordVisible: Bool
    
    init() {
        self.emailTextFieldValue = ""
        self.passwordTextFieldValue = ""
        self.confirmPasswordTextFieldValue = ""
        self.emailValidationMessage = ""
        self.passwordValidationMessage = ""
        self.confirmPasswordValidationMessage = ""
        self.isConfirmPasswordVisible = false
        self.isPasswordVisible = false
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
            Constants.DictionaryKeys.email : emailTextFieldValue,
            Constants.DictionaryKeys.password : passwordTextFieldValue
        ]
    }
}
