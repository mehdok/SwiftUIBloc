//
//  MultiBlocListenerView.swift
//  SwiftUIBloc
//
//  Created by Mehdok on 8/20/21.
//

import Combine
import SwiftUI

/// A ``BlocListener`` that will listen to 2 bloc change at the same time
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct BlocListenerViewOf2<L1, L2, V>: View
    where L1: BlocListenerBase, L2: BlocListenerBase, V: View
{
    private let l1: L1
    private let l2: L2
    private let content: V

    public init(_ l1: L1, _ l2: L2, @ViewBuilder _ content: () -> V) {
        self.l1 = l1
        self.l2 = l2
        self.content = content()
    }

    public var body: some View {
        content
            .onReceive(l1.bloc.state) { state in
                if l1.listenWhen?(l1.previousState, state) ?? true {
                    l1.listener(state)
                }
            }
            .onReceive(l2.bloc.state) { state in
                if l2.listenWhen?(l2.previousState, state) ?? true {
                    l2.listener(state)
                }
            }
    }
}

/// A ``BlocListener`` that will listen to 3 bloc change at the same time
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct BlocListenerViewOf3<L1, L2, L3, V>: View
    where L1: BlocListenerBase, L2: BlocListenerBase, L3: BlocListenerBase, V: View
{
    private let l1: L1
    private let l2: L2
    private let l3: L3
    private let content: V

    public init(_ l1: L1, _ l2: L2, _ l3: L3, @ViewBuilder _ content: () -> V) {
        self.l1 = l1
        self.l2 = l2
        self.l3 = l3
        self.content = content()
    }

    public var body: some View {
        content
            .onReceive(l1.bloc.state) { state in
                if l1.listenWhen?(l1.previousState, state) ?? true {
                    l1.listener(state)
                }
            }
            .onReceive(l2.bloc.state) { state in
                if l2.listenWhen?(l2.previousState, state) ?? true {
                    l2.listener(state)
                }
            }
            .onReceive(l3.bloc.state) { state in
                if l3.listenWhen?(l3.previousState, state) ?? true {
                    l3.listener(state)
                }
            }
    }
}

/// A ``BlocListener`` that will listen to 4 bloc change at the same time
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct BlocListenerViewOf4<L1, L2, L3, L4, V>: View
    where L1: BlocListenerBase, L2: BlocListenerBase, L3: BlocListenerBase,
    L4: BlocListenerBase, V: View
{
    private let l1: L1
    private let l2: L2
    private let l3: L3
    private let l4: L4
    private let content: V

    public init(_ l1: L1, _ l2: L2, _ l3: L3, _ l4: L4, @ViewBuilder _ content: () -> V) {
        self.l1 = l1
        self.l2 = l2
        self.l3 = l3
        self.l4 = l4
        self.content = content()
    }

    public var body: some View {
        content
            .onReceive(l1.bloc.state) { state in
                if l1.listenWhen?(l1.previousState, state) ?? true {
                    l1.listener(state)
                }
            }
            .onReceive(l2.bloc.state) { state in
                if l2.listenWhen?(l2.previousState, state) ?? true {
                    l2.listener(state)
                }
            }
            .onReceive(l3.bloc.state) { state in
                if l3.listenWhen?(l3.previousState, state) ?? true {
                    l3.listener(state)
                }
            }
            .onReceive(l4.bloc.state) { state in
                if l4.listenWhen?(l4.previousState, state) ?? true {
                    l4.listener(state)
                }
            }
    }
}

// struct BlocListenerViewOf5<L1, L2, L3, L4, L5, V>: View
//    where L1: BlocListenerBase, L2: BlocListenerBase, L3: BlocListenerBase,
//    L4: BlocListenerBase, L5: BlocListenerBase, V: View
// {
//    let l1: L1
//    let l2: L2
//    let l3: L3
//    let l4: L4
//    let l5: L5
//    let content: V
//
//    init(_ l1: L1, _ l2: L2, _ l3: L3, l4: L4, l5: L5, @ViewBuilder _ content: () -> V) {
//        self.l1 = l1
//        self.l2 = l2
//        self.l3 = l3
//        self.l4 = l4
//        self.l5 = l5
//        self.content = content()
//    }
//
//    var body: some View {
//        content
//            .onReceive(l1.bloc.state) { state in
//                if l1.listenWhen?(l1.previousState, state) ?? true {
//                    l1.listener(state)
//                }
//            }
//            .onReceive(l2.bloc.state) { state in
//                if l2.listenWhen?(l2.previousState, state) ?? true {
//                    l2.listener(state)
//                }
//            }
//            .onReceive(l3.bloc.state) { state in
//                if l3.listenWhen?(l3.previousState, state) ?? true {
//                    l3.listener(state)
//                }
//            }
//            .onReceive(l4.bloc.state) { state in
//                if l4.listenWhen?(l4.previousState, state) ?? true {
//                    l4.listener(state)
//                }
//            }
//            .onReceive(l5.bloc.state) { state in
//                if l5.listenWhen?(l5.previousState, state) ?? true {
//                    l5.listener(state)
//                }
//            }
//    }
// }
//
// struct BlocListenerViewOf6<L1, L2, L3, L4, L5, L6, V>: View
//    where L1: BlocListenerBase, L2: BlocListenerBase, L3: BlocListenerBase,
//    L4: BlocListenerBase, L5: BlocListenerBase, L6: BlocListenerBase, V: View
// {
//    let l1: L1
//    let l2: L2
//    let l3: L3
//    let l4: L4
//    let l5: L5
//    let l6: L6
//    let content: V
//
//    init(_ l1: L1, _ l2: L2, _ l3: L3, l4: L4, l5: L5, l6: L6, @ViewBuilder _ content: () -> V) {
//        self.l1 = l1
//        self.l2 = l2
//        self.l3 = l3
//        self.l4 = l4
//        self.l5 = l5
//        self.l6 = l6
//        self.content = content()
//    }
//
//    var body: some View {
//        content
//            .onReceive(l1.bloc.state) { state in
//                if l1.listenWhen?(l1.previousState, state) ?? true {
//                    l1.listener(state)
//                }
//            }
//            .onReceive(l2.bloc.state) { state in
//                if l2.listenWhen?(l2.previousState, state) ?? true {
//                    l2.listener(state)
//                }
//            }
//            .onReceive(l3.bloc.state) { state in
//                if l3.listenWhen?(l3.previousState, state) ?? true {
//                    l3.listener(state)
//                }
//            }
//            .onReceive(l4.bloc.state) { state in
//                if l4.listenWhen?(l4.previousState, state) ?? true {
//                    l4.listener(state)
//                }
//            }
//            .onReceive(l5.bloc.state) { state in
//                if l5.listenWhen?(l5.previousState, state) ?? true {
//                    l5.listener(state)
//                }
//            }
//            .onReceive(l6.bloc.state) { state in
//                if l6.listenWhen?(l6.previousState, state) ?? true {
//                    l6.listener(state)
//                }
//            }
//    }
// }

// @resultBuilder enum BlocListenerBuilder {
//    static func buildBlock<Listener>(_ listeners: Listener...) -> [Listener] where Listener: BlocListenerBase {
//        listeners
//    }
// }
//
// struct MultiBlocListenerView<B, V>: View where B: BlocListenerBase, V: View {
//    let listeners: [B]
//    @ViewBuilder var content: V
//
//    var body: some View {
//        content
//            .onReceive(Publishers.MergeMany(listeners.map { $0.bloc.state })) { state in
//                for container in listeners {
//                    if container.listenWhen?(state, state) ?? true {
//                        container.listener(state)
//                    }
//                }
//            }
//    }
// }
