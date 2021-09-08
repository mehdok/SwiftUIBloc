//
//  MainScreen.swift
//  SwiftUIBlocExample
//
//  Created by Mehdok on 9/1/21.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: CounterScreen(bloc: CounterBloc(.initial)),
                    label: {
                        Text("Counter")
                    }
                )
                .padding(.bottom)

                NavigationLink(destination: AnimeListScreen()) {
                    Text("Anime List")
                }
                .padding(.bottom)

                NavigationLink(destination: MangaListScreen(bloc: MangaListBloc(.initial))) {
                    Text("Manga List")
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
