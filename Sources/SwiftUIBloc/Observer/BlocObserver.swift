//
//  BlocObserver.swift
//  SwiftUIBloc
//
//  Created by Mehdok on 8/20/21.
//

import Foundation

/// A protocol for observing the behavior of ``Bloc`` instances.
public protocol BlocObserver {
    /// Called whenever a event is added to ``Bloc``
    func onEvent<E>(_ event: E) where E: EventBase

    /// Called whenever a ``Change`` occurs in any ``Bloc``
    /// A change occurs when a new state is emitted.
    /// ``onChange`` is called before a bloc's state has been updated.
    func onChange<S>(_ change: Change<S>) where S: StateBase

    /// Called whenever a ``Bloc`` is destroyed.
    /// ``onClose`` is called just before the ``Bloc`` is destroyed
    func onClose()
}
