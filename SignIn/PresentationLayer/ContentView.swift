//
//  ContentView.swift
//  SignIn
//
//  Created by Himanshu on 5/1/23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: properties
    
    // state objects for signin view model and navigation view model
    @StateObject private var signInViewModel = SignInViewModel()
    @StateObject private var navigationViewModel = NavigationViewModel.navigationViewModel
    
    // MARK: body
    
    var body: some View {
        
        // navigation stack with root view as SignInView()
        NavigationStack(path: $navigationViewModel.paths) {
            
            SignInView()
                .navigationDestination(for: ViewIdentifiers.self) {
                    path in
                    switch path {
                        case .SignUpView : SignInView()
                        case .SignInView : SignInView(isNewUser: false)
                        case .CompleteProfileView : CompleteProfileView()
                        case .DashboardView : DashboardView()
                    }
                }
                // hides navigation bar back button
                .navigationBarBackButtonHidden(true)
        }
        // set signInViewModel in environmentObject
        .environmentObject(signInViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
