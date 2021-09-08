//
//  AnimeListScreen.swift
//  SwiftUIBlocExample
//
//  Created by Mehdok on 8/31/21.
//

import SwiftUI
import SwiftUIBloc

struct AnimeListScreen: View {
    @EnvironmentObject var bloc: AnimeListBloc

    var body: some View {
        BlocBuilderView(BlocBuilder(bloc: bloc, buildWhen: { _, currentState in
            // We should not reload all the screen when our state is `partialLoading`
            // so we ignore this state in this builder
            currentState != .partialLoading
        }) { state in
            switch state.wrappedValue {
            case .initial:
                Text("initial state")
            case .loading:
                ProgressView()
            case .partialLoading:
                Text("we should not be here")
            case let .error(err):
                Text(err)
            case let .loaded(animeList):
                animeListView(animeList)
            }
        })
            .navigationTitle("Anime List")
            .navigationBarTitleDisplayMode(.inline)
            .onLoad {
                bloc.add(.loadMoreAnime)
            }
    }

    @ViewBuilder func animeListView(_ animeList: [AnimeResult]) -> some View {
        List {
            ForEach(animeList, id: \.malID) { anime in
                NavigationLink(destination:
                    AnimeDetailScreen(animeId: anime.malID,
                                      animeTitle: anime.title,
                                      bloc: AnimeDetailBloc(.initial))) {
                    AnimeView(anime: anime)
                        .onAppear {
                            // Load more anime at the end of the list
                            if anime == animeList.last {
                                bloc.add(.loadMoreAnime)
                            }
                        }
                }
            }

            // We just want to monitor `partialLoading` state, so we ignore other states
            BlocBuilderView(BlocBuilder(bloc: bloc, buildWhen: { _, state in
                state == .partialLoading
            }) { state in
                if case .partialLoading = state.wrappedValue {
                    centerHorizontalProgressView()
                } else {
                    Text("we should not get here 2")
                }
            })
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

struct AnimeView: View {
    let anime: AnimeResult

    var body: some View {
        VStack(alignment: .leading) {
            Text(anime.title ?? "___")
                .fontWeight(.bold)
                .padding(.bottom)

            Text(anime.synopsis ?? "___")
        }
    }
}

private struct Observer: BlocObserver {
    func onEvent<E>(_ event: E) where E: EventBase {
        print("AnimeList onEvent: \(event)")
    }

    func onChange<S>(_: Change<S>) where S: StateBase {
        print("AnimeList onChange: ")
    }

    func onClose() {
        print("AnimeList onClose")
    }
}

struct AnimeListScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnimeListScreen()
    }
}
