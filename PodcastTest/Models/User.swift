//
//  User.swift
//  QosoorApp
//
//  Created by Ammar AlTahhan on 16/07/2019.
//  Copyright © 2019 Ammar AlTahhan. All rights reserved.
//

import Foundation

class User: Codable {
    let email, userID: String
    let verified: Bool

    enum CodingKeys: String, CodingKey {
        case email
        case userID = "userId"
        case verified
    }
}





