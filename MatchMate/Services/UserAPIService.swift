//
//  UserAPIService.swift
//  MatchMate
//
//  Created by user295386 on 5/27/26.
//


import Foundation
import Combine

class UserAPIService {
    static let shared = UserAPIService()
    private let url = URL(string: "https://jsonplaceholder.typicode.com/users")!

    func fetchUsers() -> AnyPublisher<[MatchUser], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [MatchUser].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}