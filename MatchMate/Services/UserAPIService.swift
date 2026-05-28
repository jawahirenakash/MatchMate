//
//  UserAPIService.swift
//  MatchMate
//
//  Created by user295386 on 5/27/26.
//


import Foundation

class UserAPIService {
    static let shared = UserAPIService()
    
    private init() {}
    
    private let url = URL(string: "https://jsonplaceholder.typicode.com/users")!

    func fetchUsers() async throws -> [MatchUser] {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([MatchUser].self, from: data)
    }
}