import Foundation

final class MatchAPIService {
    func fetchUsers() async throws -> [MatchUser] {
        let (data, _) = try await URLSession.shared.data(from: APIConfig.API.usersURL)
        return try JSONDecoder().decode([MatchUser].self, from: data)
    }
}
