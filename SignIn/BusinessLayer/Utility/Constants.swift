//
//  Constants.swift
//  SignIn
//
//  Created by Himanshu on 5/1/23.
//

import Foundation
struct Constants {
    
    // MARK: - strings
    static let signInTitle = "%@ to Application"
    static let signInTitleCaption1 = "Create a new account to continue."
    static let signInTitleCaption2 = "Welcome back, login to continue."
    static let aboutYou = "About you"
    static let aboutYouCaption = "Tell us a bit more about you for more personalized experience."
    
    static let signUp = "Sign Up"
    static let logIn = "Log In"
    static let logOut = "Log Out"
    
    static let signUpButtonText = "Create account"
    static let loginButtonText = "Continue"
    static let profileButtonText = "Complete profile"
    
    static let emailAddress = "Email Address"
    static let password = "Password"
    static let confirmPassword = "Confirm Password"
    
    static let firstName = "First name"
    static let lastName = "Last name"
    static let age = "Age"
    static let selectGender = "Select Gender"
    static let selectImage = "Select Image"
    
    static let alreadyHaveAnAccount = "Already have an account?"
    static let dontHaveAnAccount = "Don't have an account?"
    
    // MARK: - string arrays
    static let genderOptions = ["Male", "Female", "Other"]
    
    // MARK: - urls
    static let baseURL = "https://2c60-112-196-113-2.ngrok-free.app/%@"
    static let signupURL = "users"
    static let signoutURL = "users/sign_out"
    static let signinURL = "users/sign_in"
    static let editURL = "edit"
    
    // MARK: - api related strings
    static let httpMethodPOST = "POST"
    static let httpMethodPUT = "PUT"
    static let httpMethodDELETE = "DELETE"
    static let contentType = "application/json"
    static let multipartFormData = "multipart/form-data; boundary=\(boundary)"
    static let httpHeaderField = "Content-Type"
    static let token = "token"
    static let authorization = "Authorization"
    
    static let keyUser = "user"
    
    static let keyEmail = "email"
    static let keyPassword = "password"
    
    static let keyFirstName = "first_name"
    static let keyLastName = "last_name"
    static let keyAge = "age"
    static let keyGender = "gender"
    static let keyImageUrl = "image_url"
    
    // MARK: - icons
    static let passwordHidden = "eye.slash"
    static let passwordVisible = "eye"
    static let defaultProfile = "person.circle.fill"
    
    // MARK: - regex
    static let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,16}$"
    static let ageRegEx = "[A-Za-z]+"
    
    // MARK: - errors
    static let invalidURLError = "Error: Invalid URL"
    
    // MARK: - user defaults
    static let sessionAuthToken = "Session-Auth-Token"
    
    // MARK: - others
    static let predicateFormat = "SELF MATCHES %@"
    
    static let okay = "OK"
    
    // MARK: - validation messages
    static let lessPasswordChars = "Password must contain mininum 8 characters"
    static let maxPasswordChars = "Password length exceeds max allowed length. Maximum length allowed is 16 characters"
    static let passwordMustContain = "Password must contain at least one letter, one number and one special character"
    
    static let invalidEmailAddress = "Invalid email address"
    
    static let passwordsDoNotMatch = "Passwords do not match"
    
    static let emptyTextField = "*Field is empty"
    
    static let invalidAge = "Invalid age. Only digits are allowed"
    
    // MARK: - alert errors
    static let invalidEmailPassword = "Invalid email or password"
    static let userAlreadyExists = "User already exists"
    static let unableToConnectWithServer = "Unable to connect with the server. Check your internet connection"
    static let couldntConnectToServer = "Couldn't connect to server. Please try again later"
    
    static let imageNotSetPhotosPicker = "Couldn't select a profile image"
    
    // MARK: - string format
    static let lineBreak = "\r\n"
    static let boundary = "Boundary-\(NSUUID().uuidString)"
    static let imageMimeTypeJpeg = "image/jpeg"
    static let imageContentType = "Content-Type: %@\(lineBreak + lineBreak)"
    static let imageContentDisposition = "Content-Disposition: form-data; name=\"%@\"; filename=image.jpg\(lineBreak)"
    static let dataContentDisposition = "Content-Disposition: form-data; name=\"%@\"\(lineBreak + lineBreak)"
    static let boudaryWithLineBreak = "--\(boundary + lineBreak)"

}
