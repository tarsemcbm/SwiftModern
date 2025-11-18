//
//  GitHubUserDetailView.swift
//  SwiftModern
//
//  Created by Tarsem on 2025-11-18.
//

import SwiftUI
import GitHubService

struct GitHubUserDetailView: View {
    let user: GitHubUser

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Avatar
                AsyncImage(url: URL(string: user.avatarUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .shadow(radius: 10)

                // User Info
                VStack(spacing: 8) {
                    Text(user.login)
                        .font(.title)
                        .bold()

                    if let name = user.name {
                        Text(name)
                            .font(.title3)
                            .foregroundColor(.gray)
                    }

                    if let bio = user.bio {
                        Text(bio)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                }

                // Stats
                HStack(spacing: 40) {
                    StatView(title: "Repos", value: "\(user.publicRepos)")
                    StatView(title: "Followers", value: "\(user.followers)")
                    StatView(title: "Following", value: "\(user.following)")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                if let url = URL(string: user.htmlUrl) {
                    // Open in GitHub Button
                    Link(destination: url) {
                        Label("View on GitHub", systemImage: "safari")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StatView: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2)
                .bold()
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}
