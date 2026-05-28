import Foundation
import Combine

@MainActor
final class MatchListViewModel: ObservableObject {
    @Published private(set) var matches: [MatchProfile] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let repository: MatchRepositoryProtocol
    private let networkMonitor: NetworkMonitoring
    private var cancellables = Set<AnyCancellable>()

    init(repository: MatchRepositoryProtocol, networkMonitor: NetworkMonitoring) {
        self.repository = repository
        self.networkMonitor = networkMonitor
        observeConnectivity()
        Task { await initialLoad() }
    }

    func refresh() async {
        guard networkMonitor.isConnected else {
            errorMessage = "No internet connection"
            return
        }
        isLoading = true
        errorMessage = nil
        do {
            matches = try await repository.fetchAndCache()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func accept(id: Int) {
        Task {
            await repository.updateStatus(id: id, status: .accepted)
            matches = await repository.getCachedMatches()
        }
    }

    func decline(id: Int) {
        Task {
            await repository.updateStatus(id: id, status: .declined)
            matches = await repository.getCachedMatches()
        }
    }

    private func initialLoad() async {
        matches = await repository.getCachedMatches()
        if networkMonitor.isConnected {
            await refresh()
        }
    }

    private func observeConnectivity() {
        networkMonitor.isConnectedPublisher
            .removeDuplicates()
            .sink { [weak self] connected in
                if connected {
                    Task { [weak self] in await self?.refresh() }
                }
            }
            .store(in: &cancellables)
    }
}
