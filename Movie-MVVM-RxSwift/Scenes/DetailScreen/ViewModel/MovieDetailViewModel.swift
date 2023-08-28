//
//  MovieDetailViewModel.swift
//  Movie-MVVM-RxSwift
//
//  Created by İlkay Sever on 28.08.2023.
//

import RxSwift
import RxCocoa

final class MovieDetailViewModel: BaseViewModel {
    
    let loading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let movieItem: PublishSubject<MovieItem> = PublishSubject()
    
    func fetchMovieDetail(id: Int) {
        loading.onNext(true)
        MovieRequests.shared.movieDetailRequest(id: id) { [weak self] response in
            guard let self = self else { return }
            loading.onNext(false)
            if let response = response {
                movieItem.onNext(response)
            } else {
                error.onNext(ErrorType.unknownError.rawValue)
            }
        }
    }
    
}
