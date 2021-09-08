//
//  BBTest.swift
//  SwiftUIBlocTests
//
//  Created by Mehdok on 8/20/21.
//

@testable import SwiftUIBloc
import ViewInspector
import XCTest

extension BBView: Inspectable {}
extension InitialView: Inspectable {}
extension LoadingView: Inspectable {}
extension BlocBuilderView: Inspectable {}

class BBTest: XCTestCase {
    func testInitialView() throws {
        let sut = BBView(bloc: BBBloc(.initial))
        let exp = sut.inspection.inspect(after: 0.5) { view in
            // The body should contain `InitialView`
            XCTAssertNotNil(try? view.find(InitialView.self))

            // The body should not contain `LoadingView`
            XCTAssertNil(try? view.find(LoadingView.self))
        }

        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1)
    }

    func testLoadingView() throws {
        let sut = BBView(bloc: BBBloc(.initial))
        try sut.inspect().find(button: "Show Loading").tap()

        let exp = sut.inspection.inspect(after: 0.5) { view in
            // The body should contain `LoadingView`
            XCTAssertNotNil(try? view.find(LoadingView.self))

            // The body should not contain `InitialView`
            XCTAssertNil(try? view.find(InitialView.self))
        }

        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1)
    }
}
