import Foundation

@MainActor
final class DIContainer {
    lazy var networkMonitor: NetworkMonitoring = NetworkMonitor()

    lazy var apiService: MatchAPIService = {
        MatchAPIService()
    }()

    lazy var cache: MatchCacheActor = {
        MatchCacheActor()
    }()

    lazy var matchRepository: MatchRepositoryProtocol = {
        MatchRepository(apiService: apiService, cache: cache)
    }()

    func makeMatchListViewModel() -> MatchListViewModel {
        MatchListViewModel(repository: matchRepository, networkMonitor: networkMonitor)
    }
}
