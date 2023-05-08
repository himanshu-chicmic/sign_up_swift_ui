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
    @StateObject private var viewModelObj = ViewModelBase()
    @StateObject private var navigationViewModelObj = NavigationViewModel.navigationViewModel
    
    // MARK: body
    
    var body: some View {
        
        // navigation stack with root view as SignInView()
        NavigationStack(path: $navigationViewModelObj.paths) {
            // SignInView() is the root view of app
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
        .environmentObject(viewModelObj)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
