//
//  MangaListScreen.swift
//  SwiftUIBlocExample
//
//  Created by Mehdok on 8/31/21.
//

import SwiftUI
import SwiftUIBloc

struct MangaListScreen: View {
    @ObservedObject var bloc: MangaListBloc
    @State var mangaList = [AnimeResult]()
    @State var showLoading = false
    @State var errorText = ""
    @State var showPartialLoading = false
    @State var showInitial = false

    var body: some View {
        BlocListenerView(BlocListener(bloc: bloc, listener: { state in
            showPartialLoading = state == .partialLoading
            showLoading = state == .loading
            showInitial = state == .initial

            if case let .error(err) = state {
                errorText = err
            } else {
                errorText = ""
            }

            if case let .loaded(list) = state {
                mangaList = list
            }
        })) {
            ZStack {
                if showInitial {
                    Text("initial")
                }

                if !mangaList.isEmpty {
                    mangaListView(mangaList)
                }

                if !errorText.isEmpty {
                    Text(errorText)
                }

                if showLoading {
                    ProgressView()
                }
            }
        }
        .navigationTitle("Manga List")
        .navigationBarTitleDisplayMode(.inline)
        .onLoad {
            bloc.add(.loadMoreManga)
        }
    }

    @ViewBuilder func mangaListView(_ mangaList: [AnimeResult]) -> some View {
        List {
            ForEach(mangaList, id: \.malID) { manga in
                NavigationLink(destination: MangaDetailScreen(mangaId: manga.malID, mangaTitle: manga.title, bloc: MangaDetailBloc(.initial))) {
                    AnimeView(anime: manga)
                        .onAppear {
                            // Load more anime at the end of the list
                            if manga == mangaList.last {
                                bloc.add(.loadMoreManga)
                            }
                        }
                }

                if showPartialLoading {
                    centerHorizontalProgressView()
                }
            }
        }
    }

    @ViewBuilder func centerHorizontalProgressView() -> some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}

struct MangaListScreen_Previews: PreviewProvider {
    static var previews: some View {
        MangaListScreen(bloc: MangaListBloc(.initial))
    }
}
