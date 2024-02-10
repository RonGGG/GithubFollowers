//
//  User.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 19/1/2024.
//

import Foundation

struct User: Codable {
    
    var login: String // Username
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String // Github Profile
    
    var following: Int
    var followers: Int
    var followersUrl: String // Get Followers
    
    var createdAt: Date
}
