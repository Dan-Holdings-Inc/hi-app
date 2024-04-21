//
//  ApiService.swift
//  Hi
//
//  Created by Yuma on 2024/04/15.
//

import Foundation
import Combine

enum ApiError: Error {
    case emptyData
    case invalidURL
    case decodingFailed
    case unknown
    
    var errorDescription: String {
        switch self {
        case .emptyData:
            return "ユーザーデータが存在しない"
        case .invalidURL:
            return "URLが無効"
        case .decodingFailed:
            return "デコード失敗"
        case .unknown:
            return "不明なエラー"
        }
    }
}

class ApiService {
    static let apiServer = "http://localhost:3000/"
    
    static func getUserRegistrationDto(email: String) -> AnyPublisher<UserRegistrationDto, ApiError> {
        guard let url = URL(string: apiServer + "users/" + email) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw ApiError.unknown
                }
                switch httpResponse.statusCode {
                case 200:
                    return data
                case 404:
                    throw ApiError.emptyData
                default:
                    throw ApiError.unknown
                }
            }
            .decode(type: UserRegistrationDto.self, decoder: JSONDecoder())
            .mapError { error in
                if let apiError = error as? ApiError {
                    return apiError
                } else {
                    return ApiError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
}
