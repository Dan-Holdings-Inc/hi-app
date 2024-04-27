//
//  HomeModel.swift
//  Hi
//
//  Created by Yuma on 2024/04/26.
//

import Foundation
import Combine

class HomeModel {
    static func pushHi(friendId: String, idToken: String, completion: @escaping (ApiError?) -> Void) {
        guard let url = URL(string: ApiService.apiServer + "hi/" + friendId) else {
            completion(ApiError.invalidURL)
            return
        }
        
        do {
            var request = try ApiService.buildRequest(url: url, httpMethod: "POST")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(idToken)", forHTTPHeaderField: "Authorization")
            
            // POSTリクエストの送信
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    completion(ApiError.networkError)
                    return
                }
                completion(nil) // エラーがないことを通知する
            }
            task.resume()
        } catch {
            completion(ApiError.unknown)
        }
    }
}

