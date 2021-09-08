//
//  BLView.swift
//  SwiftUIBlocTests
//
//  Created by Mehdok on 8/20/21.
//

import SwiftUI
@testable import SwiftUIBloc
import ViewInspector

struct BLView: View {
    @ObservedObject var bloc: BLBloc
    @State var text = ""
    let inspection = Inspection<Self>()

    var body: some View {
        BlocListenerView(bloc: bloc, listener: { state in
            switch state {
            case .initial:
                text = "initial"
            case let .changeTextState(str):
                text = str
            }
        }) {
            NavigationView {
                VStack {
                    Text(text)
                        .id("text_id")

                    Button("button 1") {
                        print("button 1 pressed")
                        bloc.add(.changeText("button 1 pressed"))
                    }
                    Button("button 2") {
                        bloc.add(.changeText("button 2 pressed"))
                    }
                    Button("button 3") {
                        bloc.add(.changeText("button 3 pressed"))
                    }
                }
            }
            .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
        }
    }
}
