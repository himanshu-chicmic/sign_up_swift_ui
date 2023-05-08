//
//  Data+Extension.swift
//  SignIn
//
//  Created by Himanshu on 5/3/23.
//

import Foundation

/// extension for Data
/// containg append method
/// used in appending the data from string to .utf8 format
extension Data {
   mutating func append(_ string: String) {
      if let data = string.data(using: .utf8) {
         append(data)
      }
   }
}
