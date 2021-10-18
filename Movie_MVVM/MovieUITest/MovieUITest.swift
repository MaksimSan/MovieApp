// MovieUITest.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

final class MovieUITest: XCTestCase {
    var application: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        application = XCUIApplication()
        application.launch()
    }

    func testTapOnPopularButton() {
        let popularButton = application.buttons["Popular"]
        popularButton.tap()
        XCTAssertTrue(popularButton.isEnabled)
    }

    func testTapOnUpcomingButton() {
        let upcomingButton = application.buttons["Upcoming"]
        upcomingButton.tap()
        XCTAssertTrue(upcomingButton.isEnabled)
    }

    func testTapOnTopRatedButton() {
        let topRatedButton = application.buttons["Top Rated"]
        topRatedButton.tap()
        XCTAssertTrue(topRatedButton.isEnabled)
    }

    func testTapOnCell() {
        application.buttons["Popular"].tap()
        let tableView = application.tables["Table in First Screen"]
        tableView.swipeUp(velocity: .fast)
        tableView.swipeUp(velocity: .fast)
        let cell = tableView.cells.element(boundBy: 8)
        cell.tap()
        XCTAssertTrue(!application.staticTexts["Title Details"].label.isEmpty)
    }
}
