//
//  CounterScreen.swift
//  SwiftUIBlocExample
//
//  Created by Mehdok on 9/8/21.
//

import SwiftUI
import SwiftUIBloc

struct CounterScreen: View {
    @ObservedObject var bloc: CounterBloc

    var body: some View {
        ZStack {
            BlocBuilderView(bloc: bloc) { state in
                switch state.wrappedValue {
                case .initial:
                    Text("0")
                case let .counter(count):
                    Text("\(count)")
                }
            }
            .font(.largeTitle)

            HStack {
                Spacer()

                VStack(alignment: .trailing) {
                    Spacer()

                    Fab(action: {
                        bloc.add(.increase)
                    }, label: "+")

                    Fab(action: {
                        bloc.add(.decrease)
                    }, label: "-")
                }
            }
        }
    }
}

struct CounterScreen_Previews: PreviewProvider {
    static var previews: some View {
        CounterScreen(bloc: CounterBloc(.initial))
    }
}

private struct Fab: View {
    let action: () -> Void
    let label: String

    var body: some View {
        Button(action: action, label: {
            Text(label)
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(width: 60, height: 60, alignment: .center)
        })
            .background(Color.blue)
            .clipShape(Circle())
            .shadow(radius: 10)
            .padding(.bottom)
            .padding(.trailing)
    }
}
