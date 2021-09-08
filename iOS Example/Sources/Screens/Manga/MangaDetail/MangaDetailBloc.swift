//
//  MangaDetailBloc.swift
//  SwiftUIBlocExample
//
//  Created by Mehdok on 9/1/21.
//

import Foundation
import SwiftUIBloc

final class MangaDetailBloc: Bloc<MangaDetailEvent, MangaDetailState> {
    let apiClient = ApiClient()

    override func mapEventToState(_ event: MangaDetailEvent) {
        switch event {
        case let .getMangaDetail(id):
            getMangaDetail(id)
        }
    }

    private func getMangaDetail(_ id: Int) {
        yield(.loading)

        let url = URL(string: "https://api.jikan.moe/v3/manga/\(id)")!
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

enum MangaDetailEvent: EventBase {
    case getMangaDetail(_ mangaId: Int)
}

enum MangaDetailState: StateBase {
    case initial
    case loading
    case error(_ error: String)
    case loaded(_ detail: AnimeDetail)
}
