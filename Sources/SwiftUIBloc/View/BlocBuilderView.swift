//
//  BlocBuilderView.swift
//  SwiftUIBloc
//
//  Created by Mehdok on 8/20/21.
//

import Combine
import Foundation
import SwiftUI

/// A placeholder for a closure witch accept a ``State`` and generate a ``View``
public typealias BlocViewBuilder<S, Content> = (_ state: S) -> Content where Content: View

/// A placeholder for a closure that accept ``previousState`` and ``currentState`` and produce a ``Bool``, indicating
/// whether the builder should be called or not.
public typealias BlocBuilderCondition<S> = BlocListenerCondition<S> // (_ previousState: S, _ currentState: S) -> Bool

/// An interface that confirm to ``ObservableObject`` and listen to state changes in a specified ``bloc`` to call the builder.
///
/// This interface is bond to generic type of ``BlocBase`` and ``View``.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol BlocBuilderBase: ObservableObject {
    associatedtype B: BlocBase
    associatedtype V: View

    var bloc: B { get }
    var builder: BlocViewBuilder<Binding<B.State>, V> { get }
    var buildWhen: BlocBuilderCondition<B.State>? { get }
}

/// A class that implements ``BlocBuilderBase``.
///
/// Example:
///
///     BlocBuilder(bloc: bloc, builder: { state in
///         if case .initial = state.wrappedValue {
///             InitialView()
///         } else if case .loading = state.wrappedValue {
///             LoadingView()
///         }
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public final class BlocBuilder<B, V>: BlocBuilderBase where B: BlocBase, V: View {
    public let bloc: B
    public let buildWhen: BlocBuilderCondition<B.State>?
    public let builder: BlocViewBuilder<Binding<B.State>, V>

    public init(bloc: B,
                buildWhen: BlocBuilderCondition<B.State>? = nil,
                @ViewBuilder _ builder: @escaping BlocViewBuilder<Binding<B.State>, V>)
    {
        self.bloc = bloc
        self.buildWhen = buildWhen
        self.builder = builder
    }
}

/// A ``View`` that contain a ``BlocBuilder`` and listen to state change in bloc and call the builder to update UI.
///
/// Example:
///
///     var body: some View {
///         BlocBuilderView(blocBuilder: BlocBuilder(bloc: bloc, builder: { state in
///             if case .initial = state.wrappedValue {
///                 InitialView(bloc: bloc)
///             } else if case .showLoadingState = state.wrappedValue {
///                 LoadingView(bloc: bloc)
///             } else {
///                 EmptyView()
///             }
///         }))
///     }
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct BlocBuilderView<B, V>: View where B: BlocBase, V: View {
    private let blocBuilder: BlocBuilder<B, V>
    @ObservedObject fileprivate var holder: StateHolder<B>

    public init(_ blocBuilder: BlocBuilder<B, V>) {
        self.blocBuilder = blocBuilder
        holder = StateHolder(blocBuilder.bloc.state.value)
    }

    public init(bloc: B,
                buildWhen: BlocBuilderCondition<B.State>? = nil,
                @ViewBuilder _ builder: @escaping BlocViewBuilder<Binding<B.State>, V>)
    {
        self.init(BlocBuilder(bloc: bloc, buildWhen: buildWhen, builder))
    }

    public var body: some View {
        blocBuilder.builder($holder.previousState)
            .onReceive(blocBuilder.bloc.state, perform: { state in
                if self.blocBuilder.buildWhen?(holder.previousState, state) ?? true {
                    holder.previousState = state
                }
            })
//        BlocListenerView(
//            blocListener: BlocListener(
//                bloc: blocBuilder.bloc,
//                listener: { state in
//                    holder.previousState = state
//                }, listenWhen: { previousState, currentState in
//                    blocBuilder.buildWhen?(previousState, currentState) ?? true
//                })) {
//                blocBuilder.builder($holder.previousState)
//        }
    }
}

private final class StateHolder<B>: ObservableObject where B: BlocBase {
    @Published var previousState: B.State

    init(_ previousState: B.State) {
        self.previousState = previousState
    }
}
