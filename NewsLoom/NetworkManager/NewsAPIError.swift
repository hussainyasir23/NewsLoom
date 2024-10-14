//
//  NewsAPIError.swift
//  NewsLoom
//
//  Created by Yasir on 13/10/24.
//

import Foundation

enum NewsAPIError: String, Error {
    case apiKeyDisabled
    case apiKeyExhausted
    case apiKeyInvalid
    case apiKeyMissing
    case parameterInvalid
    case parametersMissing
    case rateLimited
    case sourcesTooMany
    case sourceDoesNotExist
    case unexpectedError
    case decodingError
    case networkError
    
    var localizedDescription: String {
        switch self {
        case .apiKeyDisabled:
            return "API key has been disabled."
        case .apiKeyExhausted:
            return "API key has no more requests available."
        case .apiKeyInvalid:
            return "API key hasn't been entered correctly. Double check it and try again."
        case .apiKeyMissing:
            return "API key is missing from the request."
        case .parameterInvalid:
            return "Invalid parameter in the request."
        case .parametersMissing:
            return "Required parameters are missing from the request."
        case .rateLimited:
            return "You have been rate limited. Back off for a while before trying the request again."
        case .sourcesTooMany:
            return "You have requested too many sources in a single request. Try splitting the request into 2 smaller requests."
        case .sourceDoesNotExist:
            return "You have requested a source which does not exist."
        case .unexpectedError:
            return "An unexpected error occurred. Please try again later."
        case .decodingError:
            return "Failed to decode the response from the server."
        case .networkError:
            return "A network error occurred. Please check your internet connection and try again."
        }
    }
}
