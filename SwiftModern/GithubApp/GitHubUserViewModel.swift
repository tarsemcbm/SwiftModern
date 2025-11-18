//
//  GitHubUserViewModel.swift
//  SwiftModern
//
//  Created by Tarsem on 2025-11-18.
//

import Foundation
import GitHubService
import NetworkingKit
import Combine

@MainActor
class GitHubUserViewModel: ObservableObject {
    @Published var user: GitHubUser?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchHistory: [GitHubUser] = []

    private let gitHubService: GitHubServiceProtocol

    init(gitHubService: GitHubServiceProtocol) {
        self.gitHubService = gitHubService
    }

    func searchUser(username: String) async {
        guard !username.isEmpty else { return }

        isLoading = true
        errorMessage = nil
        user = nil

        do {
            let result = try await gitHubService.fetchUser(username: username)
            user = result

            // Add to history (move to top if exists)
            searchHistory.removeAll { $0.login == result.login }
            searchHistory.insert(result, at: 0)

        } catch {
            errorMessage = "Failed to find user: \(error.localizedDescription)"
        }

        isLoading = false
    }

    func clearHistory() {
        searchHistory.removeAll()
    }
}
