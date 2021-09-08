//
//  Bloc.swift
//  SwiftUIBloc
//
//  Created by Mehdok on 8/20/21.
//

import Combine
import Foundation

/// Represent base event to use in bloc.
public protocol EventBase: Equatable {}

/// Represent base state to use in bloc.
public protocol StateBase: Equatable {}

/// ``BlocBase`` is a  protocol that mimic a state machine witch accepts ``Event`` and produce ``State``.
///
/// ``BlocBase`` confirms to ``ObservableObject`` to accept events and publish states.
/// ``Event`` and ``State`` are generic type witch confirm to ``EventBase`` and ``StateBase``.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol BlocBase: ObservableObject {
    associatedtype Event: EventBase
    associatedtype State: StateBase

    /// Current state of state machine.
    var state: CurrentValueSubject<State, Never> { get }

    /// Add new ``Event`` to state machine.
    /// - Parameter event: A new ``Event`` to dispatch.
    func add(_ event: Event)

    /// To publish state in state machine.
    /// - Parameter state: A new ``State``.
    func yield(_ state: State)
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
open class Bloc<Event: EventBase, State: StateBase>: BlocBase {
    public private(set) var state: CurrentValueSubject<State, Never>
    private var event = PassthroughSubject<Event, Never>()

    /// A set of ``AnyCancellable`` to store any subscription.
    public var bag = Set<AnyCancellable>()

    public var observer: BlocObserver?

    public init(_ initialState: State, observer: BlocObserver? = nil) {
        state = CurrentValueSubject(initialState)
        self.observer = observer

        event
            .removeDuplicates() // remove repeated events
            .sink { [weak self] event in
                self?.mapEventToState(event)
            }.store(in: &bag)
    }

    public func add(_ event: Event) {
        observer?.onEvent(event)

        self.event.send(event)
    }

    public func yield(_ state: State) {
        // Running on the main thread
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else {
                return
            }

            // Prevent repeated state
            if self.state.value != state {
                self.observer?.onChange(Change(currentState: self.state.value, nextState: state))
                self.state.send(state)
            }
        }
    }

    /// Main method to convert any new ``Event`` to ``State``.
    /// - Parameter event: A incoming ``Event``
    open func mapEventToState(_: Event) {
        fatalError("Need to be override")
    }

    /// Invalidate the bloc
    public func invalidate() {
        observer?.onClose()

        bag.forEach {
            $0.cancel()
        }
        bag.removeAll()
    }

    deinit {
        invalidate()
    }
}
