//
//  MovieRequest.swift
//  Movie-MVVM-RxSwift
//
//  Created by İlkay Sever on 27.08.2023.
//

import Foundation

class MovieRequests {
    
    static let shared = MovieRequests()
    
    func popularMovieRequest(completion: @escaping (MovieResponseModel?) -> ()) {
        guard let url = URL(string: "\(Constants.baseURL)/movie/popular?api_key=\(Constants.apiKey)&language=en-US&page=1") else { return }
        NetworkManager.shared.request(type: MovieResponseModel.self, url: url, method: .get) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                completion(data)
            case .failure(let error):
                self.handleWithError(error)
            }
        }
    }
    
    func movieDetailRequest(id: Int, completion: @escaping (MovieItem?) -> ()) {
        guard let url = URL(string: "\(Constants.baseURL)/movie/\(id)?api_key=\(Constants.apiKey)&language=en-US") else { return }
        NetworkManager.shared.request(type: MovieItem.self, url: url, method: .get) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                completion(data)
            case .failure(let error):
                self.handleWithError(error)
            }
        }
    }
    
    private func handleWithError(_ error: Error) {
        debugPrint(error.localizedDescription)
    }
    
}
