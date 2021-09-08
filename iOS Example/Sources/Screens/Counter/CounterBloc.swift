//
//  CounterBloc.swift
//  SwiftUIBlocExample
//
//  Created by Mehdok on 9/8/21.
//

import Foundation
import SwiftUIBloc

final class CounterBloc: Bloc<CounterEvent, CounterState> {
    private var count = 0

    override func mapEventToState(_ event: CounterEvent) {
        switch event {
        case .increase:
            count += 1
            yield(.counter(count))
        case .decrease:
            count -= 1
            yield(.counter(count))
        }
    }
}

enum CounterEvent: EventBase {
    case increase
    case decrease

    static func == (_: CounterEvent, _: CounterEvent) -> Bool {
        false
    }
}

enum CounterState: StateBase {
    case initial
    case counter(Int)
}
