import Foundation

final class MatchAPIService {
    private let url = URL(string: "https://jsonplaceholder.typicode.com/users")!

    func fetchUsers() async throws -> [MatchUser] {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([MatchUser].self, from: data)
    }
}
