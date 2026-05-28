import Foundation

enum APIConfig {
    enum API {
        private static let scheme = "https"
        private static let host = "jsonplaceholder.typicode.com"
        private static let usersPath = "/users"

        static var usersURL: URL {
            var c = URLComponents()
            c.scheme = scheme
            c.host = host
            c.path = usersPath
            return c.url!
        }
    }

    enum Avatar {
        private static let baseURL = "https://i.pravatar.cc"

        static func url(for userID: Int) -> URL {
            URL(string: "\(baseURL)/150?u=\(userID)")!
        }
    }

    enum Queue {
        static let networkMonitor = "com.matchmate.networkmonitor"
    }
}
