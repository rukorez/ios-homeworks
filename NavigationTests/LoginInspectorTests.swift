//
//  LoginInspectorTests.swift
//  NavigationTests
//
//  Created by Филипп Степанов on 13.12.2022.
//

import XCTest
@testable import Navigation

final class LoginInspectorTests: XCTestCase {
    
    var loginInspector: LoginInspector!
    var loginVCMock: LoginViewControllerMock!

    override func setUpWithError() throws {
        loginInspector = LoginInspector()
        loginVCMock = LoginViewControllerMock(login: "Filipp", password: "1234")
    }
    
    override func tearDownWithError() throws {
        loginInspector = nil
        loginVCMock = nil
    }
    
    func testCorrectCheckLogin() {
        let result = loginInspector.checkLogin(login: loginVCMock.login, password: loginVCMock.password)
        
        XCTAssertTrue(result.0)
        XCTAssertNil(result.1)
    }
    
    func testWrongCheckLogin() {
        let result = loginInspector.checkLogin(login: 123, password: 456)

        XCTAssertFalse(result.0)
        XCTAssertNotNil(result.1)
    }
    
    func testWrongLoginCheckLogin() {
        let result = loginInspector.checkLogin(login: 123, password: loginVCMock.password)

        XCTAssertEqual(result.1, NSLocalizedString("loginErrorWrongLogin", comment: ""))
    }

}

class LoginViewControllerMock {
    
    var login: Int
    var password: Int
    
    init(login: String, password: String) {
        self.login = login.hash
        self.password = password.hash
    }
    
}
