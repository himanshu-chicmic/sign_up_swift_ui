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
final class ViewModelBase: ObservableObject {
    
    // bool value for showing error alerts
    @Published var showErrorAlert: Bool = false
    // error message which is shown in alerts
    // when the showErrorAlert is true
    @Published var errorMessage: String = ""
    
    // published var for user data model class
    @Published var userDataModel: UserDataModel?
    
    // instance for signin model
    var signInModel = SignInModel()
    
    // check if user is new or existing
    // this bool is used to show signup or login
    // if true show singup else show login
    // by default this var is true
    var isNewUser: Bool = true
    
    // property to get type of signin (heading/title)
    var signInType: String {
        isNewUser ? Constants.signUp : Constants.logIn
    }
    
    // propert to get signIn caption (subheading)
    var signInCaption: String {
        isNewUser ? Constants.signInTitleCaption1 : Constants.signInTitleCaption2
    }
    
    // get signin button text
    var signInButtonText: String {
        isNewUser ? Constants.signUpButtonText : Constants.loginButtonText
    }
    
    // get a string for have or do not have an account
    var haveAnAccount: String {
        isNewUser ? Constants.alreadyHaveAnAccount : Constants.dontHaveAnAccount
    }
    
    var haveAnAccountLoginSignup: String {
        isNewUser ? Constants.logIn : Constants.signUp
    }
    
    // instance of TextFieldValidations
    let textFieldValidate = TextFieldValidations()
    
    // userDetailsModel class instance
    var userDetailsModel = UserDetailsModel()
    
    // property to get the text field value color
    // in gender field (selectable in menu style)
    var textColor: Color {
        userDetailsModel.genderTextFieldValue.isEmpty ? .gray.opacity(0.5) : .black
    }
    
    // property to get selected gender
    // for showing in the menu picker
    var selectedGender: String {
        userDetailsModel.genderTextFieldValue.isEmpty ? Constants.selectGender : userDetailsModel.genderTextFieldValue
    }
    
    // selected avatar image
    var avatarImage: Image = Image(systemName: Constants.defaultProfile)
    
    
    /// method to enable error message and show alert
    /// - Parameter error: string value containg the error
    func enableErrorMessage(error: String) {
        showErrorAlert = true
        errorMessage = error
    }
    
    /// method to disable error message and show alert
    /// - Parameter error: string value containg the error
    func disableErrorMessage() {
        showErrorAlert = false
        errorMessage = ""
    }
    
    /// method to send api request
    /// this method call the function inside ApiServices class
    /// - Parameters:
    ///   - requestType: enum value containing the type of request
    ///   - data: a dictionary containg the data of type [String: String]
    func sendApiRequest(requestType: RequestType) {
        
        var data: [String: Any?] {
            switch requestType {
            case .signIn, .signUp :
                    return self.signInModel.getData()
                case .edit :
                    return self.userDetailsModel.getData()
                case .signOut :
                    return [Constants.token : UserDefaults.standard.string(forKey: Constants.sessionAuthToken) ?? ""]
            }
        }
        
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
                            
                            if let data = ApiServices.shared.userData {
                                self?.userDataModel = data
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
