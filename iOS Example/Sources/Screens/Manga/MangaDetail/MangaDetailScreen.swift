//
//  MangaDetailScreen.swift
//  SwiftUIBlocExample
//
//  Created by Mehdok on 9/1/21.
//

import SwiftUI
import SwiftUIBloc

struct MangaDetailScreen: View {
    let mangaId: Int
    let mangaTitle: String?

    @ObservedObject var bloc: MangaDetailBloc
    @State var showLoading = false
    @State var errorText = ""
    @State var mangaDetail: AnimeDetail?
    @State var showInitial = false

    var body: some View {
        BlocListenerView(bloc: bloc, listener: { state in
            showLoading = state == .loading
            showInitial = state == .initial

            if case let .error(err) = state {
                errorText = err
            } else {
                errorText = ""
            }

            if case let .loaded(detail) = state {
                mangaDetail = detail
            }
        }) {
            if showInitial {
                Text("Initial")
            }

            if showLoading {
                ProgressView()
            }

            if !errorText.isEmpty {
                Text(errorText)
            }

            if let mangaDetail = mangaDetail {
                DetailView(detail: mangaDetail)
            }
        }
        .navigationTitle(mangaTitle ?? "___")
        .navigationBarTitleDisplayMode(.inline)
        .onLoad {
            bloc.add(.getMangaDetail(mangaId))
        }
    }
}

struct MangaDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        MangaDetailScreen(mangaId: 0, mangaTitle: "", bloc: MangaDetailBloc(.initial))
    }
}
