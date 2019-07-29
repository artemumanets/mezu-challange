//
//  MezuUITests.swift
//  MezuUITests
//
//  Created by Artem Umanets on 22/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import XCTest
@testable import Mezu

class MezuUITests: XCTestCase {

    override func setUp() {

        continueAfterFailure = false

        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEnterEmptyUserNameShouldNotifyUser() {

        let app = XCUIApplication()
        app.buttons["Search"].tap()

        let errorAlert = app.alerts["Error"]
        XCTAssertNotNil(errorAlert.staticTexts["The provided username can't be empty."])
    }

    func testPressInfoButtonShouldOpenInfoScreen() {
        let app = XCUIApplication()
        app.buttons["ButtonInfo"].tap()
        app.navigationBars["Info"].buttons["ButtonClose"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let developerName = elementsQuery.staticTexts.element(matching: .any, identifier: "developerName").label
        let challangeInfo = elementsQuery.staticTexts.element(matching: .any, identifier: "titleName").label

        XCTAssertEqual(developerName, "Artem Umanets")
        XCTAssertEqual(challangeInfo, "Mezu iOS Developer Challange")
    }

    func testSearchForValidUser() {

        let app = XCUIApplication()
        app.textFields["Username"].tap()
        app.textFields["Username"].typeText("eyetwist")
        let searchButton = app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"Buscar\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        searchButton.tap()
        XCTAssertEqual(app.navigationBars["eyetwist"].otherElements["eyetwist"].label, "eyetwist")
    }
}
