protocol MatchRepositoryProtocol: AnyObject {
    func getCachedMatches() async -> [MatchProfile]
    func fetchAndCache() async throws -> [MatchProfile]
    func updateStatus(id: Int, status: MatchStatus) async
}
