//
//  MatchRepository.swift
//  MatchMate
//
//  Created by user295386 on 5/27/26.
//


import Foundation
import RealmSwift

class MatchRepository: MatchRepositoryProtocol {
    static let shared = MatchRepository()
    
    private init() {}

    func loadMatches() -> [RealmMatchObject] {
        let realm = try! Realm()
        return Array(realm.objects(RealmMatchObject.self))
    }

    func fetchAndSync() async throws {
        let users = try await UserAPIService.shared.fetchUsers()
        saveToRealm(users: users)
    }
    
    private func saveToRealm(users: [MatchUser]) {
        let realm = try! Realm()
        try! realm.write {
            for user in users {
                if let existing = realm.object(ofType: RealmMatchObject.self, forPrimaryKey: user.id) {
                    existing.name = user.name
                    existing.city = user.address.city
                    existing.company = user.company.name
                    existing.email = user.email
                } else {
                    realm.add(RealmMatchObject(from: user))
                }
            }
        }
    }

    func updateStatus(id: Int, status: MatchStatus) {
        let realm = try! Realm()
        if let match = realm.object(ofType: RealmMatchObject.self, forPrimaryKey: id) {
            try! realm.write {
                match.status = status
            }
        }
    }
}
