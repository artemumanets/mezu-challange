//
//  InitialViewModelTests.swift
//  Mezu Tests
//
//  Created by Artem Umanets on 29/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import XCTest
@testable import Mezu

class InitialViewModelTests: XCTestCase {

    var fetchExpectation: XCTestExpectation!

    let dataSourceMock: FetcherProtocol = APIFetcherMock.default
    var viewModel: InitalViewModel!
    var user: User? = nil

    override func setUp() {
        super.setUp()

        viewModel = InitalViewModel(delegate: self, dataSource: dataSourceMock)
        fetchExpectation = XCTestExpectation(description: "Get User By Name")
        user = nil
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    func testFetchUserWithValidUserNameShouldSuccess() {
        viewModel.fetchUser(username: "eyetwist")

        XCTAssertNil(user)
        wait(for: [fetchExpectation], timeout: 1.0)

        XCTAssertNotNil(user)
        XCTAssertEqual(user?.nsid, "49191827@N00")
    }
}

extension InitialViewModelTests: InitalViewModelDelegate {

    func didFetch(user: User) {
        self.user = user
        fetchExpectation.fulfill()
    }
}
