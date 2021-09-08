//
//  ViewDidLoad+Modifier.swift
//  SwiftUIBloc
//
//  Created by Mehdok on 8/30/21.
//

import SwiftUI

public struct ViewDidLoadModifier: ViewModifier {
    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    public func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }
}

public extension View {
    /// This modifier is just same as ``onAppear``, but it will just call the first time that view appear
    /// - Parameter action: action to preform
    /// - Returns: some View
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}
