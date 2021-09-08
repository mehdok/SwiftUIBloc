//
//  MBLView2.swift
//  SwiftUIBlocTests
//
//  Created by Mehdok on 8/20/21.
//

import Combine
import SwiftUI
@testable import SwiftUIBloc

struct MBLView2: View {
    @ObservedObject var bloc1: Bloc1
    @ObservedObject var bloc2: Bloc2

    @State var bloc1Text = ""
    @State var bloc2Text = ""

    let inspection = Inspection<Self>()

    var bloc1Listener: some BlocListenerBase {
        BlocListener(bloc: bloc1, listener: { state in
            switch state {
            case .initial:
                bloc1Text = "bloc 1 initial"
            case .state1:
                bloc1Text = "bloc 1 state1"
            }
        })
    }

    var bloc2Listener: some BlocListenerBase {
        BlocListener(bloc: bloc2, listener: { state in
            switch state {
            case .initial:
                bloc2Text = "bloc 2 initial"
            case .state2:
                bloc2Text = "bloc 2 state2"
            }
        })
    }

    var body: some View {
        BlocListenerViewOf2(bloc1Listener, bloc2Listener) {
            VStack {
                Text(bloc1Text)
                Text(bloc2Text)
                    .padding(.bottom)
                Button("Bloc 1 update") {
                    bloc1.add(.event1)
                }
                .padding(.bottom)
                Button("Bloc 2 update") {
                    bloc2.add(.event2)
                }
                .padding(.bottom)
            }
        }
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}
