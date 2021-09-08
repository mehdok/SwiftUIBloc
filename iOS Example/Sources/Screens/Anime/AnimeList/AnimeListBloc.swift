//
//  AnimeListBloc.swift
//  SwiftUIBlocExample
//
//  Created by Mehdok on 8/31/21.
//

import Foundation
import SwiftUIBloc

final class AnimeListBloc: Bloc<AnimeListEvent, AnimeListState> {
    var animeState = AnimeState()
    let apiClient = ApiClient()

    override func mapEventToState(_ event: AnimeListEvent) {
        switch event {
        case .loadMoreAnime:
            getNextPageAnimeList()
        }
    }

    private func getNextPageAnimeList() {
        guard animeState.canLoadNextPage else {
            return
        }

        yield(animeState.list.isEmpty ? .loading : .partialLoading)

        let url = URL(string: "https://api.jikan.moe/v3/search/anime?q=&order_by=score&sort=desc&page=\(animeState.page)")!

        apiClient.call(url) { [weak self] (completion: Result<AnimeListWrapper, APIError>) in
            switch completion {
            case let .success(list):
                self?.animeState.page += 1
                self?.animeState.list += list.results
                self?.animeState.canLoadNextPage = !list.results.isEmpty
                self?.yield(.loaded(self?.animeState.list ?? []))
            case let .failure(err):
                self?.animeState.canLoadNextPage = false
                self?.yield(.error(err.localizedDescription))
            }
        }
    }
}

enum AnimeListEvent: EventBase {
    case loadMoreAnime

    static func == (_: AnimeListEvent, _: AnimeListEvent) -> Bool {
        false
    }
}

enum AnimeListState: StateBase {
    case initial
    case loading
    case partialLoading
    case error(String)
    case loaded([AnimeResult])
}

struct AnimeState {
    var list: [AnimeResult] = []
    var page: Int = 1
    var canLoadNextPage = true
}
