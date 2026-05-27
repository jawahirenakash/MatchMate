//
//  RealmMatchObject.swift
//  MatchMate
//
//  Created by user295386 on 5/27/26.
//

import RealmSwift
import Foundation

enum MatchStatus: String, PersistableEnum {
    case pending
    case accepted
    case declined
}

class RealmMatchObject: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String = ""
    @Persisted var username: String = ""
    @Persisted var city: String = ""
    @Persisted var company: String = ""
    @Persisted var email: String = ""
    @Persisted var status: MatchStatus = .pending

    convenience init(from user: MatchUser) {
        self.init()
        self.id = user.id
        self.name = user.name
        self.username = user.username
        self.city = user.address.city
        self.company = user.company.name
        self.email = user.email
        self.status = .pending
    }
}
