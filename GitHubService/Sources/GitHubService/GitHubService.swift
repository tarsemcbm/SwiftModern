// The Swift Programming Language
// https://docs.swift.org/swift-book
import NetworkingKit
public protocol GitHubServiceProtocol {
    func fetchUser(username: String) async throws -> GitHubUser
}
public final class GitHubService: GitHubServiceProtocol {
    private let apiClient: APIClient
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    public func fetchUser(username: String) async throws -> GitHubUser {
        let endPoint = GitHubEndpoint(username: username)
        return try await apiClient.request(endPoint, responseType: GitHubUser.self)
    }
}
