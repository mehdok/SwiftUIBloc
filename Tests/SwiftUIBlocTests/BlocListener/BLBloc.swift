//
//  BLBloc.swift
//  SwiftUIBlocTests
//
//  Created by Mehdok on 8/20/21.
//

import Foundation
@testable import SwiftUIBloc

enum BLBlocEvent: EventBase {
    case changeText(String)
}

enum BLBlocState: StateBase {
    case initial
    case changeTextState(String)
}

class BLBloc: Bloc<BLBlocEvent, BLBlocState> {
    override func mapEventToState(_ event: BLBlocEvent) {
        switch event {
        case let .changeText(str):
            yield(.changeTextState(str))
        }
    }
}
