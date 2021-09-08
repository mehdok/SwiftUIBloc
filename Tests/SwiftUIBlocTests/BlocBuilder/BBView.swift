//
//  BBView.swift
//  SwiftUIBlocTests
//
//  Created by Mehdok on 8/20/21.
//

import SwiftUI
@testable import SwiftUIBloc
import ViewInspector

struct BBView: View {
    @ObservedObject var bloc: BBBloc
    let inspection = Inspection<Self>()

    var body: some View {
        BlocBuilderView(bloc: bloc) { state in
            if case .initial = state.wrappedValue {
                InitialView(bloc: bloc)
            } else if case .showLoadingState = state.wrappedValue {
                LoadingView(bloc: bloc)
            } else {
                EmptyView()
            }
        }
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

struct InitialView: View {
    var bloc: BBBloc

    var body: some View {
        VStack {
            Text("Initial View")
            Button("Show Loading") {
                bloc.add(.showLoading)
            }
        }
    }
}

struct LoadingView: View {
    var bloc: BBBloc

    var body: some View {
        VStack {
            Text("Loading ...")
        }
    }
}
