//
//  MatchListViewModel.swift
//  MatchMate
//
//  Created by user295386 on 5/27/26.
//


import Foundation
import Combine
import RealmSwift

class MatchListViewModel: ObservableObject {
    @Published var matches: [RealmMatchObject] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let repo = MatchRepository.shared
    private let network = NetworkMonitor.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        loadFromCache()
        syncIfOnline()

        // Auto-sync when connection is restored
        network.$isConnected
            .removeDuplicates()
            .sink { [weak self] online in
                if online { self?.syncIfOnline() }
            }
            .store(in: &cancellables)
    }

    private func loadFromCache() {
        matches = repo.loadMatches()
    }

    func syncIfOnline() {
        guard network.isConnected else { return }
        isLoading = true
        repo.fetchAndSync { [weak self] in
            self?.isLoading = false
            self?.loadFromCache()
        }
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
