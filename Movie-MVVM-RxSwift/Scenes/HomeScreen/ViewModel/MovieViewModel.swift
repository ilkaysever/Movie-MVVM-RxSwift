//
//  MovieViewModel.swift
//  Movie-MVVM-RxSwift
//
//  Created by İlkay Sever on 28.08.2023.
//

import RxSwift
import RxCocoa

final class MovieViewModel {
    
    let loading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let movieResponse: PublishSubject<MovieResponseModel> = PublishSubject()
    let movieList: PublishSubject<[MovieItem]> = PublishSubject()
    var totalPageCount = 1
    var initialPageCount = 1
    var movies: [MovieItem] = []
    
    func fetchPopularMovies(pageCount: Int) {
        loading.onNext(true)
        MovieRequests.shared.popularMovieRequest(pageCount: pageCount) { [weak self] response in
            guard let self = self else { return }
            loading.onNext(false)
            if let response = response, let results = response.results {
                totalPageCount = response.totalPages ?? 1
                movies += response.results ?? []
                movieResponse.onNext(response)
                movieList.onNext(results)
            } else {
                error.onNext(ErrorType.unknownError.rawValue)
            }
        }
    }
    
}
