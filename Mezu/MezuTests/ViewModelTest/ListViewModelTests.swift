//
//  ListViewModelTests.swift
//  Mezu Tests
//
//  Created by Artem Umanets on 29/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import XCTest
@testable import Mezu

class ListViewModelTests: XCTestCase {

    var fetchExpectation: XCTestExpectation!

    let testUser = User(response: FLResponseFindByUserName(user: FLUser(nsid: "49191827@N00", username: FLUserName(name: "eyetwist"))))
    let dataSourceMock: FetcherProtocol = APIFetcherMock.default
    var viewModel: ListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ListViewModel(user: testUser, delegate: self, dataSource: dataSourceMock)
        fetchExpectation = XCTestExpectation(description: "List Photos By User")
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    func testPhotosCountAfterInitialRunShouldBeEqualToTwo() {
        let initialCount = viewModel.photos.count
        viewModel.fetchPhotos()

        wait(for: [fetchExpectation], timeout: 5.0)

        let currentCount = viewModel.photos.count

        XCTAssertEqual(initialCount, 0)
        XCTAssertEqual(currentCount, 2)
    }
}

extension ListViewModelTests: ListViewModelDelegate {

    func didUpdatePhotos() {
        fetchExpectation.fulfill()
    }
}
