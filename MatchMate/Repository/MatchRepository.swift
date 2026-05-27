//
//  MatchRepository.swift
//  MatchMate
//
//  Created by user295386 on 5/27/26.
//


import Foundation
import Combine
import RealmSwift

class MatchRepository {
    static let shared = MatchRepository()
    private var cancellables = Set<AnyCancellable>()

    // Read all matches from Realm (offline-capable)
    func loadMatches() -> [RealmMatchObject] {
        let realm = try! Realm()
        return Array(realm.objects(RealmMatchObject.self))
    }

    // Fetch from API, save to Realm (only when online)
    func fetchAndSync(completion: @escaping () -> Void) {
        UserAPIService.shared.fetchUsers()
            .sink(receiveCompletion: { result in
                if case .failure(let error) = result {
                    print("API error: \(error.localizedDescription)")
                    completion() // still show cached data
                }
            }, receiveValue: { [weak self] users in
                self?.saveToRealm(users: users)
                completion()
            })
            .store(in: &cancellables)
    }
    
    private func saveToRealm(users: [MatchUser]) {
        let realm = try! Realm()
        try! realm.write {
            for user in users {
                if let existing = realm.object(ofType: RealmMatchObject.self, forPrimaryKey: user.id) {
                    // Update API fields but preserve user decision
                    existing.name = user.name
                    existing.city = user.address.city
                    existing.company = user.company.name
                    existing.email = user.email
                    // existing.status is intentionally NOT touched
                } else {
                    realm.add(RealmMatchObject(from: user))
                }
            }
        }
    }

    // Update accept/decline status
    func updateStatus(id: Int, status: MatchStatus) {
        let realm = try! Realm()
        if let match = realm.object(ofType: RealmMatchObject.self, forPrimaryKey: id) {
            try! realm.write {
                match.status = status
            }
        }
    }
}
