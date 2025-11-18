//
//  UserEndPoint.swift
//  SwiftModern
//
//  Created by Tarsem on 2025-11-04.
//
import NetworkingKit
import Foundation
struct GitHubEndpoint: Endpoint {
    var username: String
    var baseURL: String {
        "https://api.github.com"
    }
    var path: String {
        "/users/\(username)"
    }
    var method: HTTPMethod {
        .get
    }
    var headers: [String: String]? {
        [
            "Accept": "application/vnd.github.v3+json"
        ]
    }
    var queryItems: [URLQueryItem]? {
        []
    }
}
