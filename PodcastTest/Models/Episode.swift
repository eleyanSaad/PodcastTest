//
//  User.swift
//  QosoorApp
//
//  Created by Ammar AlTahhan on 16/07/2019.
//  Copyright © 2019 Ammar AlTahhan. All rights reserved.
//

import Foundation

class Episode: Codable {
    var id, itunesID: String?
       var type: Int?
       var name, description: String?
       var image, imageBigger: String?
       var audioLink: String?
       var duration, durationInSeconds, views: Int?
       var podcastItunesID, podcastName, releaseDate, createdAt: String?
       var updatedAt: String?
       var isDeleted: Bool?
       var chapters: [Chapter]?
       var isEditorPick, sentNotification: Bool?
       var position: Int?

       enum CodingKeys: String, CodingKey {
           case id
           case itunesID = "itunesId"
           case type, name, description, image, imageBigger, audioLink, duration, durationInSeconds, views
           case podcastItunesID = "podcastItunesId"
           case podcastName, releaseDate, createdAt, updatedAt, isDeleted, chapters, isEditorPick, sentNotification, position
       }
}

// MARK: - Chapter
struct Chapter: Codable {
    var start: Int?
    var title: String?
}



