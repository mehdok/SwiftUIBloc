//
//  AnimeDetailBloc.swift
//  SwiftUIBlocExample
//
//  Created by Mehdok on 8/31/21.
//

import Foundation
import SwiftUIBloc

final class AnimeDetailBloc: Bloc<AnimeDetailEvent, AnimeDetailState> {
    let apiClient = ApiClient()

    override func mapEventToState(_ event: AnimeDetailEvent) {
        switch event {
        case let .getAnimeDetail(id):
            getAnimeDetail(id)
        }
    }

    private func getAnimeDetail(_ id: Int) {
        yield(.loading)

        let url = URL(string: "https://api.jikan.moe/v3/anime/\(id)")!
        apiClient.call(url) { [weak self] (completion: Result<AnimeDetail, APIError>) in
            switch completion {
            case let .success(detail):
                self?.yield(.loaded(detail))
            case let .failure(err):
                self?.yield(.error(err.localizedDescription))
            }
        }
    }
}

enum AnimeDetailEvent: EventBase {
    case getAnimeDetail(_ animeId: Int)
}

enum AnimeDetailState: StateBase {
    case initial
    case loading
    case error(_ error: String)
    case loaded(_ detail: AnimeDetail)
}
