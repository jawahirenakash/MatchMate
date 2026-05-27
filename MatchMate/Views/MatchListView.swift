//
//  MatchListView.swift
//  MatchMate
//
//  Created by user295386 on 5/27/26.
//


import SwiftUI

struct MatchListView: View {
    @StateObject private var viewModel = MatchListViewModel()
    @StateObject private var network = NetworkMonitor.shared

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                if viewModel.isLoading && viewModel.matches.isEmpty {
                    VStack {
                        Spacer()
                        ProgressView("Loading matches...")
                        Spacer()
                    }
                } else {
                    List {
                        if !network.isConnected {
                            Label("Offline — showing cached data", systemImage: "wifi.slash")
                                .font(.caption)
                                .foregroundColor(.orange)
                                .listRowBackground(Color.orange.opacity(0.1))
                        }

                        ForEach(viewModel.matches, id: \.id) { match in
                            MatchCardView(
                                match: match,
                                onAccept: { viewModel.accept(id: match.id) },
                                onDecline: { viewModel.decline(id: match.id) }
                            )
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .buttonStyle(.plain)
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        viewModel.syncIfOnline()  // make this internal func non-private
                    }
                }
            }
            .navigationTitle("Profile Matches")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
