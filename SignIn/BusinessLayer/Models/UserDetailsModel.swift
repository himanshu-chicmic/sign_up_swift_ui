//
//  UserDetailsModel.swift
//  SignIn
//
//  Created by Nitin on 5/3/23.
//

import Foundation
import SwiftUI

struct UserDetailsModel {
    
    // state variabels for text field values
    var firstNameTextFieldValue: String = ""
    var lastNameTextFieldValue: String = ""
    var ageTextFieldValue: String = ""
    var genderTextFieldValue: String = ""
    // uiImage
    var uiImageData: UIImage = UIImage(systemName: Constants.defaultProfile)!
    
    // state variables for vaidation messages
    var firstNameValidationMessage: String = ""
    var lastNameValidationMessage: String = ""
    var ageValidationMessage: String = ""
    var genderValidationMessage: String = ""
    
    
    mutating func resetValues() {
        firstNameTextFieldValue = ""
        lastNameTextFieldValue = ""
        ageTextFieldValue = ""
        genderTextFieldValue = ""
        
        uiImageData = UIImage(systemName: Constants.defaultProfile)!
        
        firstNameValidationMessage = ""
        lastNameValidationMessage = ""
        ageValidationMessage = ""
        genderValidationMessage = ""
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
    
    func getData() -> [String: Any]{
        return [
            Constants.keyFirstName : firstNameTextFieldValue,
            Constants.keyLastName : lastNameTextFieldValue,
            Constants.keyAge : ageTextFieldValue,
            Constants.keyGender : genderTextFieldValue,
            Constants.keyImageUrl : uiImageData.jpegData(compressionQuality: 0.5) as Any
        ]
    }
}
