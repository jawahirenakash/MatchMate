//
//  MatchListViewModel.swift
//  MatchMate
//
//  Created by user295386 on 5/27/26.
//


import Foundation
import Combine
import RealmSwift

@MainActor
class MatchListViewModel: ObservableObject {
    @Published var matches: [RealmMatchObject] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let repo: MatchRepositoryProtocol
    private let network: NetworkMonitor
    private var cancellables = Set<AnyCancellable>()

    init(repo: MatchRepositoryProtocol = MatchRepository.shared, network: NetworkMonitor = .shared) {
        self.repo = repo
        self.network = network
        loadFromCache()

        if network.isConnected {
            Task { await syncIfOnline() }
        }

        network.$isConnected
            .removeDuplicates()
            .sink { [weak self] online in
                if online {
                    Task { [weak self] in await self?.syncIfOnline() }
                }
            }
            .store(in: &cancellables)
    }

    private func loadFromCache() {
        matches = repo.loadMatches()
    }

    func syncIfOnline() async {
        guard network.isConnected else { return }
        isLoading = true
        do {
            try await repo.fetchAndSync()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
        loadFromCache()
    }

    func accept(id: Int) {
        repo.updateStatus(id: id, status: .accepted)
        loadFromCache()
    }

    func decline(id: Int) {
        repo.updateStatus(id: id, status: .declined)
        loadFromCache()
    }
}
