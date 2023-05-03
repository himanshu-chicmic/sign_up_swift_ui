//
//  TextFieldAndValidationDrawer.swift
//  SignIn
//
//  Created by Nitin on 5/3/23.
//

import SwiftUI

struct TextFieldAndValidationDrawer: View {
    
    var placeholder: String
    @Binding var textFieldValue: String
    @Binding var valitaionMessage: String
    
    var body: some View {
        VStack{
            DefaultTextField(placeholder: placeholder, textFieldValue: $textFieldValue)
            ValidationMessage(validationMessage: $valitaionMessage)
        }
    }
}

