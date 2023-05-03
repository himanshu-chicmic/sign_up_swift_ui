//
//  SignInViewModel.swift
//  SignIn
//
//  Created by Himanshu on 5/2/23.
//

import Foundation
import SwiftUI


/// SignInViewModel class
/// view model class for sending api request
final class SignInViewModel: ObservableObject {
    
    // bool value for showing error alerts
    @Published var showErrorAlert: Bool = false
    // error message which is shown in alerts
    // when the showErrorAlert is true
    @Published var errorMessage: String = ""
    
    
    /// method to enable error message and show alert
    /// - Parameter error: string value containg the error
    func enableErrorMessage(error: String) {
        showErrorAlert = true
        errorMessage = error
    }
    
    
    /// method to send api request
    /// this method call the function inside ApiServices class
    /// - Parameters:
    ///   - requestType: enum value containing the type of request
    ///   - data: a dictionary containg the data of type [String: String]
    func sendApiRequest(requestType: RequestType, data: [String: Any]) {
        
        // call the apiRequest function
        ApiServices.shared.apiRequest(requestType: requestType, data: data){ [weak self] response in
            DispatchQueue.main.async {
                // check the response returned from the escaping closure
                switch response {
                    // if response is success
                    // check the result - containing the status code
                    case .success(let result):
                        // Status code: 200 (request is successfull)
                        if result == 200 {
                            switch requestType {
                                case .signUp:
                                    NavigationViewModel.navigationViewModel.push(.CompleteProfileView)
                                case .signIn, .edit:
                                    NavigationViewModel.navigationViewModel.push(.DashboardView)
                                case .signOut:
                                    NavigationViewModel.navigationViewModel.paths = [.SignInView]
                                    UserDefaults.standard.set("", forKey: Constants.sessionAuthToken)
                                }
                        }
                        // Status code: 401 (invalid email or password) returned in case of login
                        else if result == 401 {
                            self?.enableErrorMessage(error: Constants.invalidEmailPassword)
                        }
                        // Status code: 422 (user already exists) returned in the case of signup
                        else if result == 422 {
                            self?.enableErrorMessage(error: Constants.userAlreadyExists)
                        }
                        // Status code: 404 (unable to reach server or server is down)
                        else if result == 404 {
                            self?.enableErrorMessage(error: Constants.unableToConnectWithServer)
                        }
                        // else some other kind or error has occured
                        else{
                            self?.enableErrorMessage(error: Constants.couldntConnectToServer)
                        }
                    // if response is failure
                    // set the erro message and alert the user
                    case.failure(let error):
                        self?.enableErrorMessage(error: error.localizedDescription)
                }
            }
        }
    }
}
