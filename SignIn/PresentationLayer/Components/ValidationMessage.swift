//
//  PasswordTextFieldDrawer.swift
//  SignIn
//
//  Created by Himanshu on 5/2/23.
//

import SwiftUI

struct ValidationMessage: View {
    
    // binding variable for validation message
    @Binding var validationMessage: String
    
    var body: some View {
        Text(validationMessage)
            .font(.system(size: 12))
            .padding(.bottom, validationMessage.isEmpty ? 0 : 10)
            .padding(.horizontal, 4)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.red)
    }
}
