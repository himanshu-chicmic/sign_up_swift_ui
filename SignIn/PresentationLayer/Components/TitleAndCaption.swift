//
//  TitleAndCaption.swift
//  SignIn
//
//  Created by Himanshu on 5/1/23.
//

import SwiftUI

struct TitleAndCaption: View {
    
    // title and caption variables
    // string values for showing title and subtitle
    // on top of the screen
    var title: String
    var caption: String
    
    var body: some View {
        VStack{
            Text(title)
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.vertical, 6)
            
            Text(caption)
                .font(.system(size: 14))
                .padding(.bottom, 34)
                .multilineTextAlignment(.center)

        }
    }
}
