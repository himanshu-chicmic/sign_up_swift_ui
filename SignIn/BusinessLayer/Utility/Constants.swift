//
//  Constants.swift
//  SignIn
//
//  Created by Himanshu on 5/1/23.
//

import Foundation

struct Constants {
    
    // MARK: - signin view
    struct SignInView {
        
        static let titleSignUp              = "SignUp"
        static let captionSignUp            = "Create a new account to continue."
        
        static let titleLogIn               = "SignIn"
        static let captionLogIn             = "Welcome back, login to continue."
        
        static let alreadyHaveAnAccount     = "Already have an account?"
        static let dontHaveAnAccount        = "Don't have an account?"
    }
    
    // MARK: - profile view
    struct ProfileView {
        
        static let aboutYou         = "About you"
        static let aboutYouCaption  = "Tell us a bit more about you for more personalized experience."
    }
    
    // MARK: - string arrays
    struct StringArrays {
        
        static let genderOptions = ["Male", "Female", "Other"]
    }
    
    // MARK: - text button strings
    struct TextButton {
        static let signUp   = "Sign Up"
        static let logIn    = "Log In"
        static let logOut   = "Log Out"
        static let okay     = "OK"
    }
    
    // MARK: - primary button strings
    struct PrimaryButton {
        static let signUp           = "Create account"
        static let logIn            = "Continue"
        static let completeProfile  = "Complete profile"
    }
    
    // MARK: - placholder strings
    struct Placeholder {
        
        static let email            = "Email Address"
        static let password         = "Password"
        static let confirmPassword  = "Confirm Password"
        
        static let firstName        = "First name"
        static let lastName         = "Last name"
        static let age              = "Age"
        static let selectGender     = "Select Gender"
        static let selectImage      = "Select Image"
    }
    
    // MARK: - dictionary keys
    struct DictionaryKeys {
        
        static let user         = "user"
        
        static let email        = "email"
        static let password     = "password"
        
        static let firstName    = "first_name"
        static let lastName     = "last_name"
        static let age          = "age"
        static let gender       = "gender"
        static let image        = "image"
        static let imageURL     = "image_url"
        
        static let token        = "token"
    }
    
    // MARK: - icons
    struct DefaultIcons {
        
        static let passwordHidden   = "eye.slash"
        static let passwordVisible  = "eye"
        static let profilePicture   = "person.circle.fill"
    }
    
    // MARK: - user defaults
    struct UserDefaultKeys {
        
        static let sessionAuthToken = "Session-Auth-Token"
    }
    
    // MARK: - predicates
    struct PredicateFormat {
        
        static let selfMatches = "SELF MATCHES %@"
    }
    
    // MARK: - regex
    struct ValidationRegex {
        
        static let email        = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let password     = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,16}$"
        static let age          = "[A-Za-z]+"
    }
    
    // MARK: - validation messages
    struct ValidationMessages {
        
        static let passwordCountUnderflow   = "Password must contain mininum 8 characters"
        static let passwordCountOverflow    = "Password length exceeds max allowed length. Maximum length allowed is 16 characters"
        static let passwordMustContains     = "Password must contain at least one letter, one number and one special character"
        
        static let invalidEmail             = "Invalid email address"
        
        static let passwordsMismatch        = "Passwords do not match"
        
        static let emptyTextField           = "*Field is empty"
        
        static let invalidAge               = "Invalid age. Only digits are allowed"
    }
    
    // MARK: - errors
    struct Errors {
        
        static let invalidUrl               = "Error: Invalid URL"
        
        static let invalidEmailPassword     = "Invalid email or password"
        static let userAlreadyExists        = "User already exists"
        static let unableToConnect          = "Unable to connect with the server. Check your internet connection"
        static let noInternetConnection     = "Couldn't connect to server. Please try again later"
        
        static let imageNotSet              = "Couldn't select a profile image"
    }
}
