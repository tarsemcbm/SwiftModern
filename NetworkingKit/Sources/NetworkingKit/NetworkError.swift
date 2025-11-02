//
//  NetworkError.swift
//  NetworkingKit
//
//  Created by Tarsem on 2025-11-01.
//
import Foundation
public enum NetworkError: LocalizedError {
    case invalidURL
    case decodingError
    case invalidResponse
}
