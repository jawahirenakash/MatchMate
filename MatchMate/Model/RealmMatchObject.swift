//
//  RealmMatchObject.swift
//  MatchMate
//
//  Created by user295386 on 5/27/26.
//

import RealmSwift
import Foundation

extension MatchStatus: PersistableEnum {}

class RealmMatchObject: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String = ""
    @Persisted var city: String = ""
    @Persisted var company: String = ""
    @Persisted var email: String = ""
    @Persisted var status: MatchStatus = .pending

    convenience init(from user: MatchUser) {
        self.init()
        self.id = user.id
        self.name = user.name
        self.city = user.address.city
        self.company = user.company.name
        self.email = user.email
        self.status = .pending
    }
}
