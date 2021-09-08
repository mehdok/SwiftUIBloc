//
//  BlocListenerView.swift
//  SwiftUIBloc
//
//  Created by Mehdok on 8/20/21.
//

import Combine
import Foundation
import SwiftUI

/// A placeholder for a closure that  accept a ``State`` and produce nothing.
public typealias BlocViewListener<S> = (_ state: S) -> Void

/// A placeholder for a closure that accept ``previousState`` and ``currentState`` and produce a ``Bool``, indicating
/// whether the listener should be called or not.
public typealias BlocListenerCondition<S> = (_ previousState: S, _ currentState: S) -> Bool

/// An interface that confirm to ``ObservableObject`` and listen to state changes in a specified ``bloc``.
///
/// This interface is bond to generic type of ``BlocBase``.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol BlocListenerBase: ObservableObject {
    associatedtype B: BlocBase
    var bloc: B { get }
    var listener: BlocViewListener<B.State> { get }
    var listenWhen: BlocListenerCondition<B.State>? { get }
    var previousState: B.State { get }

    /// Called when state changes.
    func onUpdate()
}

/// A class that implements ``BlocListenerBase``
///
/// Example:
///
///     BlocListener(bloc: bloc, listener: { state in
///         switch state {
///         case .initial:
///             print("initial")
///         case let .showError(str):
///             showErrorAlert(str)
///         }
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public final class BlocListener<B>: BlocListenerBase where B: BlocBase {
    public let bloc: B
    public let listener: BlocViewListener<B.State>
    public let listenWhen: BlocListenerCondition<B.State>?
    public var previousState: B.State

    public init(bloc: B,
                listener: @escaping BlocViewListener<B.State>,
                listenWhen: BlocListenerCondition<B.State>? = nil)
    {
        self.bloc = bloc
        self.listener = listener
        self.listenWhen = listenWhen
        previousState = bloc.state.value
    }

    public func onUpdate() {
        previousState = bloc.state.value
    }
}

/// A ``View`` that contain a ``BlocListener`` and listen to state change in bloc and call the listener.
///
/// Example:
///
///     var body: some View {
///         BlocListenerView(
///             blocListener: BlocListener(bloc: bloc, listener: { state in
///                 switch state {
///                 case .initial:
///                     print("initial")
///                 case let .changeTextState(str):
///                     showErrorAlert(str)
///                 }
///             }),
///             content: NavigationView {
///                 VStack {
///                     Text("something")
///                 }
///             }
///     }
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct BlocListenerView<B, V>: View where B: BlocBase, V: View {
    @ObservedObject private var blocListener: BlocListener<B>
    private var content: V

    public init(_ blocListener: BlocListener<B>, @ViewBuilder _ content: @escaping () -> V) {
        self.blocListener = blocListener
        self.content = content()
    }

    public init(bloc: B,
                listener: @escaping BlocViewListener<B.State>,
                listenWhen: BlocListenerCondition<B.State>? = nil,
                @ViewBuilder _ content: @escaping () -> V)
    {
        self.init(BlocListener(bloc: bloc, listener: listener, listenWhen: listenWhen), content)
    }

    private func handleListenerEvents(_ state: B.State) {
        blocListener.listener(state)
        blocListener.onUpdate()
    }

    public var body: some View {
        content
            .onReceive(blocListener.bloc.state, perform: { state in
                if self.blocListener.listenWhen?(blocListener.previousState, state) ?? true {
                    handleListenerEvents(state)
                }
            })
    }
}
