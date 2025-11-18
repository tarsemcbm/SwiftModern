//
//  GitHubUser.swift
//  SwiftModern
//
//  Created by Tarsem on 2025-11-04.
//

import Foundation

public struct GitHubUser: Codable, Hashable, Identifiable {
    public let id: Int
    public let login: String
    public let avatarUrl: String
    public let name: String?
    public let bio: String?
    public let publicRepos: Int
    public let followers: Int
    public let following: Int
    public let htmlUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, login, name, bio, followers, following
        case avatarUrl = "avatar_url"
        case publicRepos = "public_repos"
        case htmlUrl = "html_url"
    }
}
