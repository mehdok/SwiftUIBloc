//
//  ApiClient.swift
//  SwiftUIBlocExample
//
//  Created by Mehdok on 8/24/21.
//

import Foundation

struct ApiClient {
    func call<T>(_ url: URL, completion: @escaping (Result<T, APIError>) -> Void) where T: Decodable {
        URLSession.shared
            .dataTask(with: url) { data, response, error in
                if error != nil || data == nil {
                    completion(.failure(.unknown(code: -1, description: error?.localizedDescription ?? "client error")))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      (200 ... 299).contains(httpResponse.statusCode)
                else {
                    completion(
                        .failure(
                            .serverError(description: "server error: \((response as? HTTPURLResponse)?.statusCode ?? -1)")))
                    return
                }

                do {
                    let animeList = try JSONDecoder().decode(T.self, from: data!)
                    completion(.success(animeList))
                } catch {
                    print(error)
                    completion(.failure(.jsonParseError(description: error.localizedDescription)))
                }
            }
            .resume()
    }
}
