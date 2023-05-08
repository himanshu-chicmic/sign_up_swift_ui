//
//  ApiServices.swift
//  SignIn
//
//  Created by Himanshu on 5/2/23.
//

import Foundation
import SwiftUI

/// ApiServices class containing
/// methods to interact with the api
class ApiServices {
    
    // MARK: - properties
    // a static instance of ApiServices class
    static let shared = ApiServices()
    
    // instance for user data model
    var userData: UserDataModel?
    
    // MARK: - helper methods
    
    /// returns the url endpoint (which is combined with base url)
    /// for creating a valid url for the api call
    /// - Parameter requestType: enum value to check which type of request is used
    /// - Returns: a string value containing the url endpoint
    func getStringURLArgs(requestType: RequestType) -> String {
        // constant string struct
        let endPoint = APIConstants.URLs.self
        switch requestType {
            case .signUp:   return endPoint.signUp
            case .signIn:   return endPoint.signIn
            case .signOut:  return endPoint.signOut
            case .edit:     return endPoint.edit
        }
    }
    
    /// get the header field value and key based on the request type
    /// - Parameter requestType: Type of ApiReqeust
    /// - Returns: a tuple of two strings containt value and key for header fields
    func getHeaderFieldKeyValues(requestType: RequestType) -> (String, String) {
        // constant string struct
        let fieldAndValue = APIConstants.HTTPHeaderFieldAndValues.self
        switch requestType {
            case .signUp, .signIn:
                return (fieldAndValue.applicationJson ,fieldAndValue.contentType)
            case .signOut:
                guard let tokenValue = UserDefaults.standard.string(forKey: Constants.UserDefaultKeys.sessionAuthToken) else{
                    return ("", fieldAndValue.authorization)
                }
                return (tokenValue, fieldAndValue.authorization)
            case .edit:
                return (fieldAndValue.mutlpartFormData, fieldAndValue.contentType)
        }
    }
    
    /// method to create the body of data for sending the
    /// image, and other details of user to the server
    /// used in only put request for sending the user data
    /// - Parameter params: data dictionary
    /// - Returns: body of type Data
    func createDataBody(withParameters params: [String: Any?]) -> Data {
        // initialize data object
        var body = Data()
        
        // constant string struct
        let dataBodyStrings = APIConstants.StringForDataBody.self
        
        // loop over params dictionary
        for (key, value) in params {
            
            // append boundary with a line break
            body.append(dataBodyStrings.boudaryWithLineBreakTwoHyphens)
            
            if let value = value {
                // check if key is for imageURL
                if key == Constants.DictionaryKeys.image {
                    
                    if let image = value as? UIImage{
                        body.append(String(format: dataBodyStrings.imageContentDisposition, key, "\(abs(image.hashValue)).jpeg"))
                        body.append(String(format: dataBodyStrings.imageContentType, dataBodyStrings.imageMimeJpeg))
                        
                        if let data = image.jpegData(compressionQuality: 0.7) {
                            body.append("\(data)\(dataBodyStrings.lineBreak)")
                        }
                    }
                    
                }
                // else append the other data (string, int)
                else {
                    body.append(String(format: dataBodyStrings.dataContentDisposition, key))
                    body.append("\(value)\(dataBodyStrings.lineBreak)")
                }
            }
        }
        body.append(dataBodyStrings.boudaryWithLineBreakFourHyphens)
        
        return body
    }
    
    
    // MARK: - driver/main method
    
    /// this method is the main method used to interact with api
    /// which handles all the required types of api request (POST, PUT, DELETE)
    /// - Parameters:
    ///   - requestType: enum value to check which type of request is used
    ///   - data: a dictionary containing data for sending in api request
    ///   - completion: @escaping closure to get the result when the api has returned a response or error
    func apiRequest(requestType: RequestType, data: [String: Any?], completion: @escaping (Result<Int, Error>) -> Void) {
         
        // varibale to store the usrl in string format
        let urlString = String(format: APIConstants.URLs.base, getStringURLArgs(requestType: requestType))
        
        // check if the url is valid
        guard let url = URL(string: urlString) else {
            // else return the failure message
            completion(.failure(Constants.Errors.invalidUrl as! any Error))
            return
        }
        
        // initialize the URLRequest
        var request = URLRequest(url: url)
        
        // variable to store type of http method (POST, PUT, DELETE)
        let httpMethod = requestType.rawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // set the http method for the request
        request.httpMethod = httpMethod
        
        // set header values and keys
        let headerFieldsKeyValue = getHeaderFieldKeyValues(requestType: requestType)
        request.setValue(headerFieldsKeyValue.0, forHTTPHeaderField: headerFieldsKeyValue.1)
  
        // check if http method is POST
        // the user is trying to login or signup
        if httpMethod == APIConstants.HTTPMethod.post{
            // initliaze the body dictionary
            // call the getJsonBodyData to get the data in the form of [String: AnyHashable]
            let dataBody = [Constants.DictionaryKeys.user : data]
            // set the data in http body
            request.httpBody = try? JSONSerialization.data(withJSONObject: dataBody, options: .fragmentsAllowed)
            
        }
        // if http method is PUT
        // the user is putting the personal profile data
        else if httpMethod == APIConstants.HTTPMethod.put {
            // call createDataBody method
            let dataBody = createDataBody(withParameters: data)
            // set the body
            request.httpBody = dataBody
        }
        
        // make the api request
        let task = URLSession.shared.dataTask(with: request) {
            data, resp, error in
            // check if data is not nil and error is equals to nil
            guard let dataResp = data, error == nil else {
                // if found any error
                // return failure error
                if let error {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                // if method is put handle the data
                // returned from the response
                // and decode it to UserDataModel
                if httpMethod == APIConstants.HTTPMethod.put {
                    let responseModel = try JSONDecoder().decode(UserDataModel.self, from: dataResp) as UserDataModel
                    self.userData = responseModel
                    print(self.userData?.imageURL ?? "")
                    
                    print(dataResp)
                }else {
                    let response = try JSONSerialization.jsonObject(with: dataResp, options: .allowFragments)
                    
                    print(response)
                }
                
            }catch {
                completion(.failure(error))
            }
            
            // get the authorizaton token from http url response
            // this token is later used for logout
            if let token = resp as? HTTPURLResponse {
                // get the token value
                let auth = token.value(forHTTPHeaderField: APIConstants.HTTPHeaderFieldAndValues.authorization)
                if let auth {
                    // store in user defaults
                    UserDefaults.standard.set(auth, forKey: Constants.UserDefaultKeys.sessionAuthToken)
                }
                // returns the success with the status code token
                completion(.success(token.statusCode))
            }
            
        }
        
        task.resume()
    }
    
}
