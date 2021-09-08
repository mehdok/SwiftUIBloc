//
//  MBL3Tests.swift
//  SwiftUIBlocTests
//
//  Created by Mehdok on 8/20/21.
//

import SwiftUI
@testable import SwiftUIBloc
import ViewInspector
import XCTest

extension MBLView3: Inspectable {}
extension BlocListenerViewOf3: Inspectable {}

class MBL3Tests: XCTestCase {
    func testInitialState() throws {
        let sut = MBLView3(bloc1: Bloc1(.initial), bloc2: Bloc2(.initial), bloc3: Bloc3(.initial))

        let exp = sut.inspection.inspect(after: 0.5) { view in
            let text1 = try view.actualView().bloc1Text
            XCTAssertEqual(text1, "bloc 1 initial")

            let text2 = try view.actualView().bloc2Text
            XCTAssertEqual(text2, "bloc 2 initial")

            let text3 = try view.actualView().bloc3Text
            XCTAssertEqual(text3, "bloc 3 initial")
        }

        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1)
    }

    func testBloc1StateChange() throws {
        let sut = MBLView3(bloc1: Bloc1(.initial), bloc2: Bloc2(.initial), bloc3: Bloc3(.initial))

        try sut.inspect().find(button: "Bloc 1 update").tap()

        let exp = sut.inspection.inspect(after: 0.5) { view in
            let text1 = try view.actualView().bloc1Text
            XCTAssertEqual(text1, "bloc 1 state1")

            let text2 = try view.actualView().bloc2Text
            XCTAssertEqual(text2, "bloc 2 initial")

            let text3 = try view.actualView().bloc3Text
            XCTAssertEqual(text3, "bloc 3 initial")
        }

        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1)
    }

    func testBloc2StateChange() throws {
        let sut = MBLView3(bloc1: Bloc1(.initial), bloc2: Bloc2(.initial), bloc3: Bloc3(.initial))

        try sut.inspect().find(button: "Bloc 2 update").tap()

        let exp = sut.inspection.inspect(after: 0.5) { view in
            let text1 = try view.actualView().bloc1Text
            XCTAssertEqual(text1, "bloc 1 initial")

            let text2 = try view.actualView().bloc2Text
            XCTAssertEqual(text2, "bloc 2 state2")

            let text3 = try view.actualView().bloc3Text
            XCTAssertEqual(text3, "bloc 3 initial")
        }

        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1)
    }

    func testBloc3StateChange() throws {
        let sut = MBLView3(bloc1: Bloc1(.initial), bloc2: Bloc2(.initial), bloc3: Bloc3(.initial))

        try sut.inspect().find(button: "Bloc 3 update").tap()

        let exp = sut.inspection.inspect(after: 0.5) { view in
            let text1 = try view.actualView().bloc1Text
            XCTAssertEqual(text1, "bloc 1 initial")

            let text2 = try view.actualView().bloc2Text
            XCTAssertEqual(text2, "bloc 2 initial")

            let text3 = try view.actualView().bloc3Text
            XCTAssertEqual(text3, "bloc 3 state3")
        }

        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1)
    }

    func testAllBlocStateChange() throws {
        let sut = MBLView3(bloc1: Bloc1(.initial), bloc2: Bloc2(.initial), bloc3: Bloc3(.initial))

        try sut.inspect().find(button: "Bloc 1 update").tap()
        try sut.inspect().find(button: "Bloc 2 update").tap()
        try sut.inspect().find(button: "Bloc 3 update").tap()

        let exp = sut.inspection.inspect(after: 0.5) { view in
            let text1 = try view.actualView().bloc1Text
            XCTAssertEqual(text1, "bloc 1 state1")

            let text2 = try view.actualView().bloc2Text
            XCTAssertEqual(text2, "bloc 2 state2")

            let text3 = try view.actualView().bloc3Text
            XCTAssertEqual(text3, "bloc 3 state3")
        }

        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1)
    }
}
