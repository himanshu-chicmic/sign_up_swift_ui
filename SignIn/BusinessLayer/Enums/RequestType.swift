//
//  RequestType.swift
//  SignIn
//
//  Created by Himanshu on 5/3/23.
//

import Foundation

/// enum to check the type of request user
/// wants to send to the api
enum RequestType: String {
    case signUp     = "POST"
    case signIn     = " POST" // space in prefix because duplicates not allowed (trim when used)
    case signOut    = "DELETE"
    case edit       = "PUT"
}
