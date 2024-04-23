//
//  AccountCommonModel.swift
//  Hi
//
//  Created by Yuma on 2024/04/21.
//

import Foundation
import Combine

class AccountCreateModel {
    static func postUserData(userRegistrationDto: UserRegistrationDto) -> AnyPublisher<UserWithRelatedData, ApiError> {
        guard let url = URL(string: ApiService.apiServer + "users/") else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        do {
            var request = try ApiService.buildRequest(url: url, httpMethod: "POST")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(userRegistrationDto)
            print(String(data: request.httpBody!, encoding: .utf8) ?? "")
            
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
