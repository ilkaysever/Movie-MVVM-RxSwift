//
//  NetworkManager.swift
//  Movie-MVVM-RxSwift
//
//  Created by İlkay Sever on 27.08.2023.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Codable>(type: T.Type, url: URL, method: HTTPMethod, completion: @escaping((Result<T, ErrorType>) -> ())) {
        AF.request(url, method: method).response { response in
            switch response.result {
            case .success(let data):
                self.handleResponse(data: data!) { response in
                    completion(response)
                }
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
    
    private func handleResponse<T: Codable>(data: Data, completion: @escaping((Result<T, ErrorType>) -> ())) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(.parsingError))
        }
    }
    
}
