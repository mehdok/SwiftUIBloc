//
//  Change.swift
//  SwiftUIBloc
//
//  Created by Mehdok on 8/20/21.
//

import Foundation

/// A ``Change`` represents the change from one ``State`` to another.
///
/// A ``Change`` consists of the ``currentState`` and ``nextState``.
public struct Change<State>: Equatable where State: StateBase {
    /// The current ``State`` at the time of the ``Change``.
    public let currentState: State

    /// The next ``State`` at the time of the ``Change``.
    public let nextState: State

    public static func == (lhs: Change, rhs: Change) -> Bool {
        lhs.currentState == rhs.currentState &&
            lhs.nextState == rhs.nextState
    }

    public var description: String {
        "Transition { currentState: \(currentState), nextState: \(nextState) }"
    }
}
