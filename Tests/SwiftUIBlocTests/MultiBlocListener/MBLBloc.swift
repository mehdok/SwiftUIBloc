//
//  MBLBloc.swift
//  SwiftUIBlocTests
//
//  Created by Mehdok on 8/20/21.
//

import Foundation
@testable import SwiftUIBloc

enum Event1: EventBase {
    case event1
}

enum State1: StateBase {
    case initial
    case state1
}

class Bloc1: Bloc<Event1, State1> {
    override func mapEventToState(_ event: Event1) {
        switch event {
        case .event1:
            yield(.state1)
        }
    }
}

///

enum Event2: EventBase {
    case event2
}

enum State2: StateBase {
    case initial
    case state2
}

class Bloc2: Bloc<Event2, State2> {
    override func mapEventToState(_ event: Event2) {
        switch event {
        case .event2:
            yield(.state2)
        }
    }
}

///

enum Event3: EventBase {
    case event3
}

enum State3: StateBase {
    case initial
    case state3
}

class Bloc3: Bloc<Event3, State3> {
    override func mapEventToState(_ event: Event3) {
        switch event {
        case .event3:
            yield(.state3)
        }
    }
}

///

enum Event4: EventBase {
    case event4
}

enum State4: StateBase {
    case initial
    case state4
}

class Bloc4: Bloc<Event4, State4> {
    override func mapEventToState(_ event: Event4) {
        switch event {
        case .event4:
            yield(.state4)
        }
    }
}
