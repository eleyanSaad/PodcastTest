//
//  User.swift
//  QosoorApp
//
//  Created by Ammar AlTahhan on 16/07/2019.
//  Copyright © 2019 Ammar AlTahhan. All rights reserved.
//

import Foundation

class Playlist: Codable {
    var id: String?
    var type: Int?
    var name, description: String?
    var image: String?
    var access, status: String?
    var episodeCount, episodeTotalDuration: Int?
    var createdAt, updatedAt: String?
    var isDeleted: Bool?
    var followingCount: Int?
    var userID: String?
    var isSubscribed: Bool?

    enum CodingKeys: String, CodingKey {
        case id, type, name, description, image, access, status, episodeCount, episodeTotalDuration, createdAt, updatedAt, isDeleted, followingCount
        case userID = "userId"
        case isSubscribed
    }
}





