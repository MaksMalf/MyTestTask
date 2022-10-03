//
//  UserModel.swift
//  MyTestTask
//
//  Created by Maksim Malofeev on 10/3/22.
//

import Foundation

struct User: Codable  {
    let firstName: String
    let lastName: String
    let phone: String
    let email: String
    let password: String
    let age: Date
}
