//
//  DefaultTextField.swift
//  SignIn
//
//  Created by Himanshu on 5/2/23.
//

import SwiftUI


/// view for showing default text fields in the app
struct DefaultTextField: View {
    
    // textfield placeholder string
    var placeholder: String
    // binding variable for textfield value
    @Binding var textFieldValue: String
    
    var body: some View {
        TextField(placeholder, text: $textFieldValue)
            .font(.system(size: 14))
            .padding()
            .frame(height: 52)
            .background(.gray.opacity(0.25))
            .cornerRadius(6)
    }
}
