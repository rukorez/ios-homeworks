//
//  FeedPresenterTests.swift
//  NavigationTests
//
//  Created by Филипп Степанов on 13.12.2022.
//

import XCTest
@testable import Navigation

final class FeedPresenterTests: XCTestCase {
    
    var feedPresenter: FeedPresenter!
    var feedVCMock: FeedViewControllerMock!

    override func setUpWithError() throws {
        feedPresenter = FeedPresenter()
        feedVCMock = FeedViewControllerMock(password: "Password")
        feedPresenter.input = feedVCMock
    }

    override func tearDownWithError() throws {
        feedPresenter = nil
        feedVCMock = nil
    }
    
    func testCheckCorrectPassword() {
        feedPresenter.passData(data: feedVCMock.password)
        
        XCTAssertTrue(feedVCMock.bool!)
    }
    
    func testCheckWrongPassword() {
        feedPresenter.passData(data: "1234")
        
        XCTAssertFalse(feedVCMock.bool!)
    }
    
    func testShowNextModule() {
        feedPresenter.sendData()
        
        XCTAssertEqual(feedVCMock.nextModule, "Go To Next Module")
    }

}

class FeedViewControllerMock: PresenterControllerInput {
    
    var password: String
    var bool: Bool?
    var nextModule: String?
    
    init(password: String) {
        self.password = password
    }
    
    func updateData(data: Bool) {
        self.bool = data
    }
    
    func showNextModule(goTo: @escaping () -> Void) {
        nextModule = "Go To Next Module"
    }
    
}
