//
//  Inspection.swift
//  SwiftUIBlocTests
//
//  Created by Mehdok on 8/20/21.
//

import Combine
import ViewInspector

final class Inspection<V> {
    let notice = PassthroughSubject<UInt, Never>()
    var callbacks = [UInt: (V) -> Void]()

    func visit(_ view: V, _ line: UInt) {
        if let callback = callbacks.removeValue(forKey: line) {
            callback(view)
        }
    }
}

extension Inspection: InspectionEmissary where V: Inspectable {}
