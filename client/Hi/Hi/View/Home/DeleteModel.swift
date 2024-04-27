//
//  DeleteModel.swift
//  Hi
//
//  Created by ryosei on 2024/04/28.
//

import Foundation
import Combine

class DeleteModel {
    static func DeleteData(id:String) -> AnyPublisher<User, ApiError> {
        guard let url = URL(string: ApiService.apiServer + "users/" + id) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        do {
            var request = try ApiService.buildRequest(url: url, httpMethod: "DELETE")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
