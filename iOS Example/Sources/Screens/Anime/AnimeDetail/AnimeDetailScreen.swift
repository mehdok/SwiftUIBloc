//
//  AnimeDetailScreen.swift
//  SwiftUIBlocExample
//
//  Created by Mehdok on 8/31/21.
//

import SwiftUI
import SwiftUIBloc

struct AnimeDetailScreen: View {
    let animeId: Int
    let animeTitle: String?
    @StateObject var bloc = AnimeDetailBloc(.initial)

    var body: some View {
        BlocBuilderView(BlocBuilder(bloc: bloc) { state in
            switch state.wrappedValue {
            case .initial:
                Text("initial state")
            case .loading:
                ProgressView()
            case let .error(err):
                Text(err)
            case let .loaded(detail):
                DetailView(detail: detail)
            }
        })
            .navigationTitle(animeTitle ?? "___")
            .navigationBarTitleDisplayMode(.inline)
            .onLoad {
                bloc.add(.getAnimeDetail(animeId))
            }
    }
}

struct DetailView: View {
    let detail: AnimeDetail

    var body: some View {
        ScrollView {
            image(detail.imageURL)

            VStack(alignment: .leading, spacing: 8) {
                if let titleEnglish = detail.titleEnglish {
                    HStack(alignment: .top) {
                        Text("English title")
                            .fontWeight(.bold)

                        Text(titleEnglish)
                    }
                }

                if let titleJapanese = detail.titleJapanese {
                    HStack(alignment: .top) {
                        Text("Japanese title")
                            .fontWeight(.bold)

                        Text(titleJapanese)
                    }
                }

                HStack(alignment: .top) {
                    Text("genere:")
                        .fontWeight(.bold)
                    Text(detail.genres?.map { $0.name ?? "" }.joined(separator: ", ") ?? "")
                }

                if let synopsis = detail.synopsis {
                    Text("synopsis:")
                        .fontWeight(.bold)
                    Text(synopsis)
                }

                if let background = detail.background {
                    Text("background:")
                        .fontWeight(.bold)
                    Text(background)
                }
            }
            .padding()
        }
    }

    @ViewBuilder func image(_ url: String?) -> some View {
        if let url = url {
            NetworkImageView(withURL: url, height: 200)
        } else {
            Image(systemName: "icloud.slash")
        }
    }
}

struct AnimeDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnimeDetailScreen(animeId: 1, animeTitle: "___")
    }
}
