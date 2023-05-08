//
//  TextFieldAndValidationDrawer.swift
//  SignIn
//
//  Created by Himanshu on 5/3/23.
//

import SwiftUI


/// view use to draw/create default text field
/// and validation message together
struct TextFieldAndValidationDrawer: View {
    
    // placeholder for text field
    var placeholder: String
    
    // binding variables for textfield value and validation message
    @Binding var textFieldValue: String
    @Binding var valitaionMessage: String
    
    
    var body: some View {
        VStack{
            // text field
            DefaultTextField(placeholder: placeholder, textFieldValue: $textFieldValue)
            // validation message
            ValidationMessage(validationMessage: $valitaionMessage)
        }
    }
}

