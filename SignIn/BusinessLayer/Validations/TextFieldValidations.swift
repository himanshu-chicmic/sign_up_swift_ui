//
//  TextFieldValidations.swift
//  SignIn
//
//  Created by Himanshu on 5/2/23.
//

import Foundation


/// struct containing methods for
/// text fields validations
struct TextFieldValidations {
    
    
    /// method to validate age
    /// - Parameter value: value of age text field
    /// - Returns: a string value containing validation message
    func validateAgeTextField(value: String) -> String {
        // variable to store the regular expression
        let regEx = Constants.ageRegEx
        // set a predicate value used to validate value with regEx
        let predicate = NSPredicate(format: Constants.predicateFormat, regEx)
        
        // if value is empty or validate is successfull
        // return empty string
        // empty string indicates no error message will be shown to user
        if value.isEmpty {
            return Constants.emptyTextField
        }
        else if predicate.evaluate(with: value) {
            return Constants.invalidAge
        }
        return ""
    }
    
    /// method to validate email or password that returns a string value containg validation message
    /// is validation message is empty the value is successfully validated otherwise the message
    /// tells user what need to be corrected
    /// - Parameters:
    ///   - value: value (email or password) to be validate
    ///   - flag: if true the value is a password else it's a emai
    /// - Returns: validation message string
    func validateEmailPassword(value: String, flag: Bool) -> String {
        
        // variable to store the regular expression
        let regEx = flag ? Constants.passwordRegEx : Constants.emailRegEx
        // set a predicate value used to validate value with regEx
        let predicate = NSPredicate(format: Constants.predicateFormat, regEx)
        
        // if value is empty or validate is successfull
        // return empty string
        // empty string indicates no error message will be shown to user
        if value.isEmpty || predicate.evaluate(with: value) {
            return ""
        }
        
        // if flag true
        // validate for password
        if flag {
            if value.count < 8 {
                return Constants.lessPasswordChars
            }
            else if value.count > 16 {
                return Constants.maxPasswordChars
            }
            return Constants.passwordMustContain
            
        }
        // else validate for email
        return Constants.invalidEmailAddress
        
    }
    
    
    /// method to match password and confirm password
    /// - Parameters:
    ///   - originalPassword: the main password
    ///   - confirmPassword: password for confirm password field
    /// - Returns: validation message string
    func validateConfirmPassword(originalPassword: String, confirmPassword: String) -> String {
        
        // passwords do not match
        if !confirmPassword.isEmpty && originalPassword != confirmPassword {
            return Constants.passwordsDoNotMatch
        }
        // passwords match
        return ""
        
    }
    
    
    /// method to check for any empty text fields
    /// - Parameter text: string value of a text field
    /// - Returns: validate message string
    func checkEmptyTextFields(text: String) -> String? {
        text.isEmpty ? Constants.emptyTextField : ""
    }
    
    
    /// method to return a bool value if any of validate message is not empty
    /// the returned bool value is used to check whether to call the api request or not
    /// - Parameter stringArray: a string array containg the values of validationMessages
    /// - Returns: true or false
    func checkIfValidationMessageIsEmpty(_ stringArray: [String]) -> Bool {
        for text in stringArray {
            if !text.isEmpty {
                return false
            }
        }
        return true
    }
}
