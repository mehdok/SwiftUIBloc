//
//  APIError.swift
//  SwiftUIBlocExample
//
//  Created by Mehdok on 8/24/21.
//

import Foundation

public enum APIError: Error, Equatable, LocalizedError {
    case jsonParseError(description: String)
    case serverError(description: String)
    case unknown(code: Int, description: String)
    case undefined

    public var errorDescription: String? {
        switch self {
        case let .jsonParseError(error):
            return error
        case let .serverError(error):
            return error
        case let .unknown(_, error):
            return error
        case .undefined:
            return "undefined error"
        }
    }
}
