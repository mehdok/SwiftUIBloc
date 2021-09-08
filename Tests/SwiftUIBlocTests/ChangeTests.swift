//
//  ChangeTests.swift
//  SwiftUIBlocTests
//
//  Created by Mehdok on 8/20/21.
//

@testable import SwiftUIBloc
import XCTest

class ChangeTests: XCTestCase {
    enum TestState: StateBase {
        case firstState
        case secondState
        case thirdState
    }

    func testChangeEquality() throws {
        let change1 = Change(currentState: TestState.firstState, nextState: TestState.secondState)
        let change2 = Change<TestState>(currentState: .firstState, nextState: .secondState)

        XCTAssertEqual(change1, change2)
        XCTAssertEqual(change1.description, change2.description)
    }

    func testChangeUnEquality() throws {
        let change1 = Change(currentState: TestState.firstState, nextState: TestState.secondState)
        let change2 = Change<TestState>(currentState: .secondState, nextState: .thirdState)

        XCTAssertNotEqual(change1, change2)
        XCTAssertNotEqual(change1.description, change2.description)
    }
}
