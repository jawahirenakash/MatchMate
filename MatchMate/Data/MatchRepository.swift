import Foundation

final class MatchRepository: MatchRepositoryProtocol {
    private let apiService: MatchAPIService
    private let cache: MatchCacheActor

    init(apiService: MatchAPIService, cache: MatchCacheActor) {
        self.apiService = apiService
        self.cache = cache
    }

    func getCachedMatches() async -> [MatchProfile] {
        await cache.loadMatches()
    }

    func fetchAndCache() async throws -> [MatchProfile] {
        let users = try await apiService.fetchUsers()
        await cache.saveMatches(users)
        return await cache.loadMatches()
    }

    func updateStatus(id: Int, status: MatchStatus) async {
        await cache.updateStatus(id: id, status: status)
    }
}
