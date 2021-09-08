//
//  BBBloc.swift
//  SwiftUIBlocTests
//
//  Created by Mehdok on 8/20/21.
//

import Foundation
@testable import SwiftUIBloc

enum BBEvent: EventBase {
    case showLoading
}

enum BBState: StateBase {
    case initial
    case showLoadingState
}

class BBBloc: Bloc<BBEvent, BBState> {
    override func mapEventToState(_ event: BBEvent) {
        switch event {
        case .showLoading:
            yield(.showLoadingState)
        }
    }
}
