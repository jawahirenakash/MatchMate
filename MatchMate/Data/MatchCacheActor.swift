@preconcurrency import RealmSwift

actor MatchCacheActor {

    static let schemaVersion: UInt64 = 2

    static func configureMigration() {
        let config = Realm.Configuration(
            schemaVersion: schemaVersion,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < schemaVersion {
                    migration.enumerateObjects(ofType: RealmMatchObject.className()) { _, newObject in
                        newObject?[AppConstants.RealmKey.status] = MatchStatus.pending.rawValue
                    }
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
    }

    func loadMatches() -> [MatchProfile] {

        let realm = try! Realm()
        return MainActor.run { realm.objects(RealmMatchObject.self).map { object in
                MatchProfile(
                    id: object.id,
                    name: object.name,
                    email: object.email,
                    city: object.city,
                    company: object.company,
                    status: object.status
                )
            }
        }
    }

    func saveMatches(_ users: [MatchUser]) {
        MainActor.run {
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
    }

    func updateStatus(id: Int, status: MatchStatus) {
        MainActor.run {
            let realm = try! Realm()
            if let match = realm.object(ofType: RealmMatchObject.self, forPrimaryKey: id) {
                try! realm.write {
                    match.status = status
                }
            }
        }
    }
}
