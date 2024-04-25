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
    case encodingFailed
    case unknown
    
    var errorDescription: String {
        switch self {
        case .emptyData:
            return "ユーザーデータが存在しない"
        case .invalidURL:
            return "URLが無効"
        case .decodingFailed:
            return "デコード失敗"
        case .encodingFailed:
            return "エンコード失敗"
        case .unknown:
            return "不明なエラー"
        }
    }
}

class ApiService {
    static let apiServer = "http://localhost:3000/"
    
    static func buildRequest(url: URL, httpMethod: String) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        return request
    }
    
    static func handleResponse(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.unknown
        }
        switch httpResponse.statusCode {
        case 200:
            return data
        case 404:
            throw try checkResponseMessage(data: data)
        default:
            throw ApiError.unknown
        }
    }
    
    static func handleError(error: Error) -> ApiError {
        if let apiError = error as? ApiError {
            return apiError
        } else if error is DecodingError {
            return .decodingFailed
        } else if error is EncodingError {
            return .encodingFailed
        } else {
            return .unknown
        }
    }
    
    static func checkResponseMessage(data: Data) throws -> ApiError {
        do {
            if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let errorMessage = jsonResponse["message"] as? String {
                return errorMessage == "user not registered yet." ? .emptyData : .unknown
            } else {
                // エラーレスポンスがJSON形式ではない場合やmessageフィールドが存在しない場合
                return ApiError.unknown
            }
        } catch {
            // JSON解析エラーが発生した場合や、messageフィールドがString型でない場合
            return ApiError.unknown
        }
    }
}
