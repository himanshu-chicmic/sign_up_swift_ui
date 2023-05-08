//
//  APIConstants.swift
//  SignIn
//
//  Created by Himanshu on 5/8/23.
//

import Foundation

struct APIConstants {
    
    // MARK: - api urls
    struct URLs{
        
        static let base     = "https://23f0-112-196-113-2.ngrok-free.app/%@"
        static let signUp   = "users"
        static let signOut  = "users/sign_out"
        static let signIn   = "users/sign_in"
        static let edit     = "edit"
    }
    
    // MARK: - http method
    struct HTTPMethod {
        
        static let post     = "POST"
        static let put      = "PUT"
        static let delete   = "DELETE"
    }
    
    // MARK: - https header fields and values
    struct HTTPHeaderFieldAndValues {
        // values
        static let mutlpartFormData = "multipart/form-data"
        static let applicationJson  = "application/json"
    
        // headers
        static let contentType      = "Content-Type"
        static let authorization    = "Authorization"
    }
    
    // MARK: - string format
    struct StringForDataBody {
        
        static let lineBreak                        = "\r\n"
        static let boundary                         = "Boundary-\(NSUUID().uuidString)"
        
        static let multipartFormData                = "\(HTTPHeaderFieldAndValues.mutlpartFormData); boundary=\(boundary)"
        
        static let imageMimeJpeg                    = "image/jpeg"
        
        static let imageContentType                 = "Content-Type: %@\(lineBreak + lineBreak)"
        
        static let imageContentDisposition          = "Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\(lineBreak)"
        static let dataContentDisposition           = "Content-Disposition: form-data; name=\"%@\"\(lineBreak + lineBreak)"
        
        static let boudaryWithLineBreakTwoHyphens   = "--\(boundary + lineBreak)"
        static let boudaryWithLineBreakFourHyphens  = "--\(boundary)--\(lineBreak)"
    }
}
