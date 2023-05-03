//
//  NavigationViewModel.swift
//  SignIn
//
//  Created by Himanshu on 5/2/23.
//

import Foundation

/// NavigationViewModel class
/// view model class used for navigation using navigation stack paths
final class NavigationViewModel: ObservableObject {
    
    // a static instance of navigation view model class
    static let navigationViewModel = NavigationViewModel()
    
    
    private init() {
        if let val = UserDefaults.standard.value(forKey: Constants.sessionAuthToken) as? String{
            if !val.isEmpty {
                push(.DashboardView)
            }
        }
    }
    
    // array to store paths
    @Published var paths: [ViewIdentifiers] = []
    
    
    /// method to push path to the paths array
    /// - Parameter path: a view identifier
    func push(_ path: ViewIdentifiers) {
        paths.append(path)
    }
    
    
    /// pop the last value from paths list
    /// and navigate back
    func pop() {
        paths.removeLast(1)
    }
}
