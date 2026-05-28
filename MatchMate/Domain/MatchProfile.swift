struct MatchProfile: Identifiable, Sendable {
    let id: Int
    let name: String
    let email: String
    let city: String
    let company: String
    var status: MatchStatus
}
