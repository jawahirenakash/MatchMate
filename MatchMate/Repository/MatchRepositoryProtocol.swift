protocol MatchRepositoryProtocol {
    func loadMatches() -> [RealmMatchObject]
    func fetchAndSync() async throws
    func updateStatus(id: Int, status: MatchStatus)
}
