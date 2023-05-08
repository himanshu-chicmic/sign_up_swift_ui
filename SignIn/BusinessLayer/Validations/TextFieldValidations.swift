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
        let regEx = Constants.ValidationRegex.age
        // set a predicate value used to validate value with regEx
        let predicate = NSPredicate(format: Constants.PredicateFormat.selfMatches, regEx)
        
        // if value is empty or validate is successfull
        // return empty string
        // empty string indicates no error message will be shown to user
        if value.isEmpty {
            return Constants.ValidationMessages.emptyTextField
        }
        else if predicate.evaluate(with: value) {
            return Constants.ValidationMessages.invalidAge
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
        
        // validation regex struct
        let validationRegex = Constants.ValidationRegex.self
        
        // variable to store the regular expression
        let regEx = flag ? validationRegex.password : validationRegex.email
        // set a predicate value used to validate value with regEx
        let predicate = NSPredicate(format:Constants.PredicateFormat.selfMatches, regEx)
        
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
                return Constants.ValidationMessages.passwordCountUnderflow
            }
            else if value.count > 16 {
                return Constants.ValidationMessages.passwordCountOverflow
            }
            return Constants.ValidationMessages.passwordMustContains
            
        }
        // else validate for email
        return Constants.ValidationMessages.invalidEmail
        
    }
    
    
    /// method to match password and confirm password
    /// - Parameters:
    ///   - originalPassword: the main password
    ///   - confirmPassword: password for confirm password field
    /// - Returns: validation message string
    func validateConfirmPassword(originalPassword: String, confirmPassword: String) -> String {
        
        // passwords do not match
        if !confirmPassword.isEmpty && originalPassword != confirmPassword {
            return Constants.ValidationMessages.passwordsMismatch
        }
        // passwords match
        return ""
        
    }
    
    
    /// method to check for any empty text fields
    /// - Parameter text: string value of a text field
    /// - Returns: validate message string
    func checkEmptyTextFields(text: String) -> String? {
        text.isEmpty ? Constants.ValidationMessages.emptyTextField : ""
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
