//
//  UserDataModel.swift
//  SignIn
//
//  Created by Himanshu on 5/4/23.
//

import Foundation

// MARK: - UserDataModel
struct UserDataModel: Codable {
    let status: Status
    let imageURL: URL?

    enum CodingKeys: String, CodingKey {
        case status
        case imageURL = "image_url"
    }
}

// MARK: - Status
struct Status: Codable {
    let code: Int
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let userID: Int
    let firstName, lastName: String
    let age: Int
    let gender: String
    let id: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case userID     = "user_id"
        case firstName  = "first_name"
        case lastName   = "last_name"
        case age, gender, id
        case createdAt  = "created_at"
        case updatedAt  = "updated_at"
    }
}
