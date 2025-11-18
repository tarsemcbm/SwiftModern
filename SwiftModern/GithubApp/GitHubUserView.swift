//
//  GitHubUserView.swift
//  SwiftModern
//
//  Created by Tarsem on 2025-11-04.
//

import SwiftUI
import GitHubService

struct GitHubUserView: View {
    @StateObject private var viewModel: GitHubUserViewModel
    @State private var username = ""

    init(viewModel: GitHubUserViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                searchBar

                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Searching...")
                    Spacer()
                } else if let error = viewModel.errorMessage {
                    Spacer()
                    errorView(error)
                    Spacer()
                } else if viewModel.searchHistory.isEmpty {
                    Spacer()
                    emptyStateView
                    Spacer()
                } else {
                    historyList
                }
            }
            .navigationTitle("GitHub Users")
            .toolbar {
                if !viewModel.searchHistory.isEmpty {
                    Button("Clear") {
                        viewModel.clearHistory()
                    }
                }
            }
        }
    }

    private var searchBar: some View {
        HStack {
            TextField("Enter username", text: $username)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .submitLabel(.search)
                .onSubmit {
                    searchUser()
                }

            Button("Search") {
                searchUser()
            }
            .buttonStyle(.borderedProminent)
            .disabled(username.isEmpty)
        }
        .padding()
    }

    private var historyList: some View {
        List {
            ForEach(viewModel.searchHistory) { user in
                NavigationLink(value: user) {
                    HStack(spacing: 12) {
                        AsyncImage(url: URL(string: user.avatarUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.login)
                                .font(.headline)
                            if let name = user.name {
                                Text(name)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }

                        Spacer()

                        VStack(alignment: .trailing) {
                            Text("\(user.publicRepos)")
                                .font(.caption)
                                .bold()
                            Text("repos")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: GitHubUser.self) { user in
            GitHubUserDetailView(user: user)
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            Text("Search for a GitHub user")
                .font(.headline)
                .foregroundColor(.gray)
        }
    }

    private func errorView(_ message: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.red)
            Text(message)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
        }
    }

    private func searchUser() {
        Task {
            await viewModel.searchUser(username: username)
            username = ""
        }
    }
}
