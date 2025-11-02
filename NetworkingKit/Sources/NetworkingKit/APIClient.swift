//
//  APIClient.swift
//  NetworkingKit
//
//  Created by Tarsem on 2025-11-01.
//

import Foundation

public protocol APIClient {
    func request<T: Decodable>(
        _ endpoint: Endpoint,
        responseType: T.Type
    ) async throws -> T
}

public final class DefaultAPIClient: APIClient {
    private let session: URLSession
    public init(session: URLSession = .shared) {
        self.session = session
    }
    public func request<T>(
        _ endpoint: any Endpoint,
        responseType: T.Type)
    async throws -> T where T : Decodable {
        let request = try endpoint.asURLRequest()
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
