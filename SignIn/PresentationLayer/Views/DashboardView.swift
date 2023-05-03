//
//  DashboardView.swift
//  SignIn
//
//  Created by Himanshu on 5/1/23.
//

import SwiftUI

struct DashboardView: View {
    
    // MARK: properties
    
    // environment object of signin viewmodel
    @EnvironmentObject private var signInViewModel: SignInViewModel
    
    // MARK: body
    
    var body: some View {
        Button(action: {
            // send api request on button click to log out user
            // and clear the session
            signInViewModel.sendApiRequest(requestType: .signOut, data: [Constants.token : UserDefaults.standard.string(forKey: Constants.sessionAuthToken) ?? ""])
        }, label: {
            Text(Constants.logOut)
        })
        // hides navigation back button
        .navigationBarBackButtonHidden(true)
        .alert(signInViewModel.errorMessage, isPresented: $signInViewModel.showErrorAlert) {
                Button(Constants.okay, role: .cancel) {
                    signInViewModel.showErrorAlert = false
                    signInViewModel.errorMessage = ""
                }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
