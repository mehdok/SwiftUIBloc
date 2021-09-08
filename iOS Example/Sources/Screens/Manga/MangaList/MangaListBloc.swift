//
//  MangaListBloc.swift
//  SwiftUIBlocExample
//
//  Created by Mehdok on 8/31/21.
//

import Foundation
import SwiftUIBloc

final class MangaListBloc: Bloc<MangaListEvent, MangaListState> {
    var mangaState = AnimeState()
    let apiClient = ApiClient()

    override func mapEventToState(_ event: MangaListEvent) {
        switch event {
        case .loadMoreManga:
            getNextPageMangaList()
        }
    }

    private func getNextPageMangaList() {
        guard mangaState.canLoadNextPage else {
            return
        }

        yield(mangaState.list.isEmpty ? .loading : .partialLoading)

        let url = URL(string: "https://api.jikan.moe/v3/search/manga?q=&order_by=score&sort=desc&page=\(mangaState.page)")!

        apiClient.call(url) { [weak self] (completion: Result<AnimeListWrapper, APIError>) in
            switch completion {
            case let .success(list):
                self?.mangaState.page += 1
                self?.mangaState.list += list.results
                self?.mangaState.canLoadNextPage = !list.results.isEmpty
                self?.yield(.loaded(self?.mangaState.list ?? []))
            case let .failure(err):
                self?.mangaState.canLoadNextPage = false
                self?.yield(.error(err.localizedDescription))
            }
        }
    }
}

enum MangaListEvent: EventBase {
    case loadMoreManga

    static func == (_: MangaListEvent, _: MangaListEvent) -> Bool {
        false
    }
}

enum MangaListState: StateBase {
    case initial
    case loading
    case partialLoading
    case error(String)
    case loaded([AnimeResult])
}
