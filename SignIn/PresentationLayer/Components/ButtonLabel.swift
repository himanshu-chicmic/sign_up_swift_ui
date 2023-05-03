//
//  ButtonLabel.swift
//  SignIn
//
//  Created by Himanshu on 5/1/23.
//

import SwiftUI

struct ButtonLabel: View {
    
    // variable for text on button
    var buttonText: String
    
    var body: some View {
        Text(buttonText)
            .frame(maxWidth: .infinity)
            .padding()
            .background(.blue)
            .cornerRadius(6)
            .foregroundColor(.white)
            .font(.system(size: 15))
            .fontWeight(.semibold)
    }
}
