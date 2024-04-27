//
//  SettingModel.swift
//  Hi
//
//  Created by ryosei on 2024/04/26.
//

import Foundation
import Combine

class SettingModel {
    static func putUserData(userchangeDto: UserChangeDto, id:String) -> AnyPublisher<User, ApiError> {
        guard let url = URL(string: ApiService.apiServer + "users/" + id) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        do {
            var request = try ApiService.buildRequest(url: url, httpMethod: "PUT")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(userchangeDto)
            print(String(data: request.httpBody!, encoding: .utf8) ?? "")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    try ApiService.handleResponse(data: data, response: response)
                }
                .decode(type: User.self, decoder: JSONDecoder())
                .mapError { error in
                    ApiService.handleError(error: error)
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: ApiError.unknown).eraseToAnyPublisher()
        }
    }
}
