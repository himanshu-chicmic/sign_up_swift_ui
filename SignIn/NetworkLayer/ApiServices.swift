//
//  ApiServices.swift
//  SignIn
//
//  Created by Himanshu on 5/2/23.
//

import Foundation


/// ApiServices class containing
/// methods to interact with the api
class ApiServices {
    
    
    // a static instance of ApiServices class
    static let shared = ApiServices()
    
    
    /// returns the url endpoint (which is combined with base url)
    /// for creating a valid url for the api call
    /// - Parameter requestType: enum value to check which type of request is used
    /// - Returns: a string value containing the url endpoint
    func getStringURLArgs(requestType: RequestType) -> String {
        switch requestType {
            case .signUp:
                return Constants.signupURL
            case .signIn:
                return Constants.signinURL
            case .signOut:
                return Constants.signoutURL
            case .edit:
                return Constants.editURL
        }
    }

    
    /// returns the http method (in string form) to be used for api request
    /// - Parameter requestType: enum value to check which type of request is used
    /// - Returns: a string value of the httpMethod type (i.e., POST, PUT, DELETE)
    func getHttpMethod(requestType: RequestType) -> String {
        switch requestType {
        case .signUp, .signIn:
            return Constants.httpMethodPOST
        case .signOut:
            return Constants.httpMethodDELETE
        case .edit:
            return Constants.httpMethodPUT
        }
    }
    
    
    /// method to create the body of data for sending the
    /// image, and other details of user to the server
    /// used in only put request for sending the user data
    /// - Parameter params: data dictionary
    /// - Returns: body of type Data
    func createDataBody(withParameters params: [String: Any]) -> Data {
        // initialize data object
        var body = Data()
        
        // loop over params dictionary
        for (key, value) in params {
            
            // append boundary with a line break
            
            body.append(Constants.boudaryWithLineBreak)
            
            // check if key is for imageURL
            if key == Constants.keyImageUrl {
                body.append(String(format: Constants.imageContentDisposition, key))
                body.append(String(format: Constants.imageContentType, Constants.imageMimeTypeJpeg))
                
                if let value = value as? Data {
                    
                    body.append("\(value) \(Constants.lineBreak)")
                }
            }
            // else append the other data (string, int)
            else {
                
                body.append(String(format: Constants.dataContentDisposition, key))
                body.append("\(value)\(Constants.lineBreak)")
            }
        }
        
        body.append("--\(Constants.boundary)--\(Constants.lineBreak)")
        
        return body
    }
    
    /// this method is the main method used to interact with api
    /// which handles all the required types of api request (POST, PUT, DELETE)
    /// - Parameters:
    ///   - requestType: enum value to check which type of request is used
    ///   - data: a dictionary containing data for sending in api request
    ///   - completion: @escaping closure to get the result when the api has returned a response or error
    func apiRequest(requestType: RequestType, data: [String: Any], completion: @escaping (Result<Int, Error>) -> Void) {
        
        // varibale to store the usrl in string format
        let urlString = String(format: Constants.baseURL, getStringURLArgs(requestType: requestType))
        
        // check if the url is valid
        guard let url = URL(string: urlString) else {
            // else return the failure message
            completion(.failure(Constants.invalidURLError as! any Error))
            return
        }
        
        // initialize the URLRequest
        var request = URLRequest(url: url)
        
        // variable to store type of http method (POST, PUT, DELETE)
        let httpMethod = getHttpMethod(requestType: requestType)
        
        // set the http method for the request
        request.httpMethod = httpMethod
        
        // check if http method is POST
        // the user is trying to login or signup
        if httpMethod == Constants.httpMethodPOST {
            // set header value for Content-Type
            request.setValue(Constants.contentType, forHTTPHeaderField: Constants.httpHeaderField)
            // initliaze the body dictionary
            // call the getJsonBodyData to get the data in the form of [String: AnyHashable]
            let body = [Constants.keyUser : data]
            // set the data in http body
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            
        }
        // if http method is PUT
        // the user is putting the personal profile data
        else if httpMethod == Constants.httpMethodPUT {
            
            // set content type
            request.setValue(Constants.multipartFormData, forHTTPHeaderField: Constants.httpHeaderField)
            
            // call createDataBody method
            let dataBody = createDataBody(withParameters: data)
            
            // set the body
            request.httpBody = dataBody
        }
        // else the request is DELETE
        // the logout process is carried out
        else {
            // for logout set the header value for authorization
            if let token = data[Constants.token] as? String {
                request.setValue(token, forHTTPHeaderField: Constants.authorization)
            }
            
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
            
            // get the authorizaton token from http url response
            // this token is later used for logout
            if let token = resp as? HTTPURLResponse {
                // get the token value
                let auth = token.value(forHTTPHeaderField: Constants.authorization)
                if let auth {
                    // store in user defaults
                    UserDefaults.standard.set(auth, forKey: Constants.sessionAuthToken)
                }
                // returns the success with the status code token
                completion(.success(token.statusCode))
            }
            
            do {
                let response = try JSONSerialization.jsonObject(with: dataResp, options: .allowFragments)
                print(response)
            }catch {
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
}
