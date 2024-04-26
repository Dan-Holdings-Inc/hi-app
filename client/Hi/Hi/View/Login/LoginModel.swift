//
//  LoginModel.swift
//  Hi
//
//  Created by Yuma on 2024/04/21.
//

import Foundation
import Combine

class LoginModel {
    static func getUserWithRelationship(email: String) -> AnyPublisher<UserWithRelatedData, ApiError> {
        guard let url = URL(string: ApiService.apiServer + "users/" + email) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        do {
            let request = try ApiService.buildRequest(url: url, httpMethod: "GET")
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    try ApiService.handleResponse(data: data, response: response)
                }
                .decode(type: UserWithRelatedData.self, decoder: JSONDecoder())
                .mapError { error in
                    ApiService.handleError(error: error)
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: ApiError.unknown).eraseToAnyPublisher()
        }
    }
}
