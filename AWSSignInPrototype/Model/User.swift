//
//  User.swift
//  AWSSignInPrototype
//
//  Created by Greg Hughes on 3/28/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation

struct User : Codable {
    let username : String
    let email : String
    let uuid : String
    let password : String
    
}
