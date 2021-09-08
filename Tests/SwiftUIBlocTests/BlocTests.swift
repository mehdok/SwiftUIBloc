//
//  BlocTests.swift
//  SwiftUIBlocTests
//
//  Created by Mehdok on 8/20/21.
//

import CombineExpectations
@testable import SwiftUIBloc
import XCTest

class BlocTests: XCTestCase {
    func testInitialState() throws {
        let bloc = TestBloc(.initial)
        let recorder = bloc.state.record()
        let firstState = try wait(for: recorder.next(), timeout: 1)
        if case .initial = firstState {} else { XCTFail() }
    }

    func testAddingSingleEvent() throws {
        let bloc = TestBloc(.initial)

        let recorder = bloc.state.record()

        // initial state
        _ = try wait(for: recorder.next(), timeout: 1)

        // dispatching first event
        bloc.add(.firstEvent)
        let state = try wait(for: recorder.next(), timeout: 1)
        if case .firstState = state {} else { XCTFail() }
    }

    func testAddingMultipleEvents() throws {
        let bloc = TestBloc(.initial)

        let recorder = bloc.state.record()

        bloc.add(.firstEvent)
        bloc.add(.secondEvent)
        bloc.add(.thirdEvent)

        let expectation = recorder.availableElements
        let elements = try wait(for: expectation, timeout: 1)

        XCTAssertEqual(elements, [.initial, .firstState, .secondState, .thirdState])
    }

    func testAddingRepeatingEvents() throws {
        let bloc = TestBloc(.initial)

        let recorder = bloc.state.record()

        bloc.add(.firstEvent)
        bloc.add(.firstEvent)

        let expectation = recorder.availableElements
        let elements = try wait(for: expectation, timeout: 1)
        XCTAssertEqual(elements, [.initial, .firstState])

        // repetitive state should not be dispatched
        XCTAssertNotEqual(elements, [.initial, .firstState, .firstState])
    }

    func testOverrideEquality() throws {
        let bloc = TestBloc(.initial)

        let recorder = bloc.state.record()

        bloc.add(.forthEvent)
        bloc.add(.forthEvent)

        let expectation = recorder.availableElements
        let elements = try wait(for: expectation, timeout: 1)

        // [.initial, .forthState, .forthState]
        XCTAssertEqual(elements.count, 3)
    }

    func testBlocDeInit() throws {
        let observer = TestBlocObserver()

        var bloc: TestBloc? = TestBloc(.initial, observer: observer)

        // do stuff
        bloc?.add(.firstEvent)
        bloc?.add(.secondEvent)
        bloc?.add(.thirdEvent)
        bloc?.add(.forthEvent)

        bloc = nil

        XCTAssertTrue(observer.blocDeInitCalled)
    }
}

enum TestEvent: EventBase {
    case firstEvent
    case secondEvent
    case thirdEvent
    case forthEvent

    static func == (lhs: TestEvent, rhs: TestEvent) -> Bool {
        switch (lhs, rhs) {
        case (.firstEvent, .firstEvent):
            return true
        case (.secondEvent, .secondEvent):
            return true
        case (.thirdEvent, .thirdEvent):
            return true
        case (.forthEvent, .forthEvent):
            return false
        default:
            return false
        }
    }
}

enum TestState: StateBase {
    case initial
    case firstState
    case secondState
    case thirdState
    case forthState

    static func == (lhs: TestState, rhs: TestState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial):
            return true
        case (.firstState, .firstState):
            return true
        case (.secondState, .secondState):
            return true
        case (.thirdState, .thirdState):
            return true
        case (.forthState, .forthState):
            return false
        default:
            return false
        }
    }
}

class TestBloc: Bloc<TestEvent, TestState> {
    override func mapEventToState(_ event: TestEvent) {
        switch event {
        case .firstEvent:
            yield(.firstState)
        case .secondEvent:
            yield(.secondState)
        case .thirdEvent:
            yield(.thirdState)
        case .forthEvent:
            yield(.forthState)
        }
    }
}

class TestBlocObserver: BlocObserver {
    var blocDeInitCalled = false

    func onEvent<E>(_: E) where E: EventBase {}

    func onChange<S>(_: Change<S>) where S: StateBase {}

    func onClose() {
        blocDeInitCalled = true
    }
}
