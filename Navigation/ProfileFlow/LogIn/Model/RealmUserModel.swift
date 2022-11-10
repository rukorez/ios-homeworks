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
    
    var config: Realm.Configuration {
        return Realm.Configuration(encryptionKey: getKey())
    }
    
    private func refreshDatabase() {
        do {
            let realm = try Realm(configuration: config)
            users = Array(realm.objects(RealmUser.self))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addUser(login: String, password: String) {
        guard login != "", password != "" else { return }
        do {
            let realm = try Realm(configuration: config)
            try realm.write({
                let user = RealmUser()
                user.login = login
                user.password = password
                user.isAuthtorized = false
                realm.add(user)
            })
            refreshDatabase()
        } catch {
            print(error.localizedDescription)
        }
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
    
    func getKey() -> Data {
        // Identifier for our keychain entry - should be unique for your application
        let keychainIdentifier = "io.Realm.EncryptionExampleKey"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        // First check in the keychain for an existing key
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]
        // To avoid Swift optimization bug, should use withUnsafeMutablePointer() function to retrieve the keychain item
        // See also: http://stackoverflow.com/questions/24145838/querying-ios-keychain-using-swift/27721328#27721328
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            // swiftlint:disable:next force_cast
            return dataTypeRef as! Data
        }
        // No pre-existing key from this application, so generate a new one
        // Generate a random encryption key
        var key = Data(count: 64)
        key.withUnsafeMutableBytes({ (pointer: UnsafeMutableRawBufferPointer) in
            let result = SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
            assert(result == 0, "Failed to get random bytes")
        })
        // Store the key in the keychain
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: key as AnyObject
        ]
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
        return key
    }
}
