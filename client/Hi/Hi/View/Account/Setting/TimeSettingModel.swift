//
//  TimeSettingModel.swift
//  Hi
//
//  Created by ryosei on 2024/04/27.
//

import Foundation
import Combine

class TimeSettingModel {
    static func putUserData(timechangeDto: TimeChangeDto, id:String) -> AnyPublisher<Time, ApiError> {
        guard let url = URL(string: ApiService.apiServer + "users/" + id + "/alarm") else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        do {
            var request = try ApiService.buildRequest(url: url, httpMethod: "PUT")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(timechangeDto)
            print(String(data: request.httpBody!, encoding: .utf8) ?? "")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    try ApiService.handleResponse(data: data, response: response)
                }
                .decode(type: Time.self, decoder: JSONDecoder())
                .mapError { error in
                    ApiService.handleError(error: error)
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: ApiError.unknown).eraseToAnyPublisher()
        }
    }
}
