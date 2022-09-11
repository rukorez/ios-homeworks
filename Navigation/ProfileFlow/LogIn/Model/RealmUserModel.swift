//
//  RealmUserModel.swift
//  Navigation
//
//  Created by Филипп Степанов on 10.09.2022.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    
    @Persisted var login: String
    @Persisted var password: String
    @Persisted var isAuthtorized: Bool
    
}

class RealmUserModel {
    
    static var defaultModel = RealmUserModel()
    
    init() {
        migrate()
        refreshDatabase()
    }
    
    var users: [RealmUser] = []
    
    private func refreshDatabase() {
        let realm = try! Realm()
        users = Array(realm.objects(RealmUser.self))
    }
    
    func addUser(login: String, password: String) {
        guard login != "", password != "" else { return }
        let realm = try! Realm()
        try! realm.write({
            let user = RealmUser()
            user.login = login
            user.password = password
            user.isAuthtorized = false
            realm.add(user)
        })
        refreshDatabase()
    }
    
    func checkUser(login: String) -> Bool {
        if users.contains(where: { $0.login == login }) {
            return true
        } else {
            return false
        }
    }
    
    func deleteUser(login: String) {
        let realm = try! Realm()
        try! realm.write({
            let user = users.filter { $0.login == login }
            realm.delete(user)
        })
        refreshDatabase()
    }
    
    private func migrate() {
        let config = Realm.Configuration(schemaVersion: 2)
        Realm.Configuration.defaultConfiguration = config
    }
}
