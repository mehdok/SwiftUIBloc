//
//  BLTests.swift
//  SwiftUIBlocTests
//
//  Created by Mehdok on 8/20/21.
//

import Foundation
import SwiftUI
@testable import SwiftUIBloc
import ViewInspector
import XCTest

extension BLView: Inspectable {}
extension BlocListenerView: Inspectable {}

class BLTests: XCTestCase {
    func testInitialState() throws {
        let sut = BLView(bloc: BLBloc(.initial))

        let exp = sut.inspection.inspect(after: 0.5) { view in
            let text = try view.actualView().text
            XCTAssertEqual(text, "initial")
        }

        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1)
    }

    func testFirstButtonTap() throws {
        let sut = BLView(bloc: BLBloc(.initial))

        try sut.inspect().find(button: "button 1").tap()

        let exp = sut.inspection.inspect(after: 0.5) { view in
            let text1 = try view.actualView().text
            XCTAssertEqual(text1, "button 1 pressed")
        }

        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1)
    }

    func testSecondButtonTap() throws {
        let sut = BLView(bloc: BLBloc(.initial))

        try sut.inspect().find(button: "button 2").tap()

        let exp = sut.inspection.inspect(after: 0.5) { view in
            let text1 = try view.actualView().text
            XCTAssertEqual(text1, "button 2 pressed")
        }

        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1)
    }

    func testThreeButtonTap() throws {
        let sut = BLView(bloc: BLBloc(.initial))

        try sut.inspect().find(button: "button 3").tap()

        let exp = sut.inspection.inspect(after: 0.5) { view in
            let text1 = try view.actualView().text
            XCTAssertEqual(text1, "button 3 pressed")
        }

        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1)
    }

    func testInitialStateUI() throws {
        let sut = BLView(bloc: BLBloc(.initial))

        let exp = sut.inspection.inspect(after: 0.5) { view in
            let text = try self.getTextFromUI(view)
            XCTAssertEqual(text, "initial")
        }

        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1)
    }

    func testFirstButtonTapUI() throws {
        let sut = BLView(bloc: BLBloc(.initial))

        try sut.inspect().find(button: "button 1").tap()

        let exp = sut.inspection.inspect(after: 0.5) { view in
            let text1 = try self.getTextFromUI(view)
            XCTAssertEqual(text1, "button 1 pressed")
        }

        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1)
    }

    func testSecondButtonTapUI() throws {
        let sut = BLView(bloc: BLBloc(.initial))

        try sut.inspect().find(button: "button 2").tap()

        let exp = sut.inspection.inspect(after: 0.5) { view in
            let text1 = try self.getTextFromUI(view)
            XCTAssertEqual(text1, "button 2 pressed")
        }

        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1)
    }

    func testThreeButtonTapUI() throws {
        let sut = BLView(bloc: BLBloc(.initial))

        try sut.inspect().find(button: "button 3").tap()

        let exp = sut.inspection.inspect(after: 0.5) { view in
            let text1 = try self.getTextFromUI(view)
            XCTAssertEqual(text1, "button 3 pressed")
        }

        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1)
    }

    func getTextFromUI(_ view: InspectableView<ViewType.View<BLView>>)
        throws -> String
    {
        try view
            .view(BlocListenerView<BLBloc, BLView>.self)
            .navigationView()
            .vStack(0)
            .text(0)
            .string()
    }
}
