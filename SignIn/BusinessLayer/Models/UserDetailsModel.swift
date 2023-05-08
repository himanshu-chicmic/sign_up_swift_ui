//
//  UserDetailsModel.swift
//  SignIn
//
//  Created by Himanshu on 5/3/23.
//

import Foundation
import SwiftUI

struct UserDetailsModel {
    
    // state variabels for text field values
    var firstNameTextFieldValue: String
    var lastNameTextFieldValue: String
    var ageTextFieldValue: String
    var genderTextFieldValue: String
    // uiImage
    var uiImageData: UIImage?
    
    // state variables for vaidation messages
    var firstNameValidationMessage: String
    var lastNameValidationMessage: String
    var ageValidationMessage: String
    var genderValidationMessage: String
    
    init() {
        self.firstNameTextFieldValue = ""
        self.lastNameTextFieldValue = ""
        self.ageTextFieldValue = ""
        self.genderTextFieldValue = ""
        self.uiImageData = nil
        self.firstNameValidationMessage = ""
        self.lastNameValidationMessage = ""
        self.ageValidationMessage = ""
        self.genderValidationMessage = ""
    }
    
    mutating func checkForValidations(textFieldValidate: TextFieldValidations) {
        // check if any field is left empty
        firstNameValidationMessage = textFieldValidate.checkEmptyTextFields(text: firstNameTextFieldValue) ?? firstNameValidationMessage
        lastNameValidationMessage = textFieldValidate.checkEmptyTextFields(text: lastNameTextFieldValue) ?? lastNameValidationMessage
    
        ageValidationMessage = textFieldValidate.validateAgeTextField(value: ageTextFieldValue)
    
        genderValidationMessage = textFieldValidate.checkEmptyTextFields(text: genderTextFieldValue) ?? genderValidationMessage
    }
    
    func checkForValidationMessages(textFieldValidate: TextFieldValidations) -> Bool {
        return textFieldValidate.checkIfValidationMessageIsEmpty(
            [firstNameValidationMessage, lastNameValidationMessage, ageValidationMessage, genderValidationMessage]
        )
    }
    
    func getData() -> [String: Any?]{
        return [
            Constants.DictionaryKeys.firstName : firstNameTextFieldValue,
            Constants.DictionaryKeys.lastName : lastNameTextFieldValue,
            Constants.DictionaryKeys.age : ageTextFieldValue,
            Constants.DictionaryKeys.gender : genderTextFieldValue,
            Constants.DictionaryKeys.image : uiImageData
        ]
    }
}
