//
//  MBLView3.swift
//  SwiftUIBlocTests
//
//  Created by Mehdok on 8/20/21.
//

import Combine
import SwiftUI
@testable import SwiftUIBloc

struct MBLView3: View {
    @ObservedObject var bloc1: Bloc1
    @ObservedObject var bloc2: Bloc2
    @ObservedObject var bloc3: Bloc3

    @State var bloc1Text = ""
    @State var bloc2Text = ""
    @State var bloc3Text = ""

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

    var bloc3Listener: some BlocListenerBase {
        BlocListener(bloc: bloc3, listener: { state in
            switch state {
            case .initial:
                bloc3Text = "bloc 3 initial"
            case .state3:
                bloc3Text = "bloc 3 state3"
            }
        })
    }

    var body: some View {
        BlocListenerViewOf3(bloc1Listener, bloc2Listener, bloc3Listener) {
            VStack {
                Text(bloc1Text)
                Text(bloc2Text)
                Text(bloc3Text)
                    .padding(.bottom)
                Button("Bloc 1 update") {
                    bloc1.add(.event1)
                }
                .padding(.bottom)
                Button("Bloc 2 update") {
                    bloc2.add(.event2)
                }
                .padding(.bottom)
                Button("Bloc 3 update") {
                    bloc3.add(.event3)
                }
                .padding(.bottom)
            }
        }
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}
