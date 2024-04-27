//
//  FriendSearchModel.swift
//  Hi
//
//  Created by Yuma on 2024/04/28.
//

import Foundation
import Combine

class FriendSearchModel {
    static func getUserList(searchWord: String) -> AnyPublisher<[User], ApiError> {
        guard let url = URL(string: ApiService.apiServer + "search/users?text=" + searchWord) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        do {
            let request = try ApiService.buildRequest(url: url, httpMethod: "GET")
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    try ApiService.handleResponse(data: data, response: response)
                }
                .decode(type: [User].self, decoder: JSONDecoder())
                .mapError { error in
                    ApiService.handleError(error: error)
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: ApiError.unknown).eraseToAnyPublisher()
        }
    }
}
