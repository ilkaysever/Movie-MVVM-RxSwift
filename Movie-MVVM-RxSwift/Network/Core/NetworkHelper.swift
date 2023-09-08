//
//  NetworkHelper.swift
//  Movie-MVVM-RxSwift
//
//  Created by İlkay Sever on 27.08.2023.
//

import Foundation

struct Constants {
    static let apiKey = "bd7847090fea4f76f5ce0c22bd1a85b8"
    static let baseURL = "https://api.themoviedb.org/3"
    static let imgBaseURL = "https://image.tmdb.org/t/p/w500"
}

enum ErrorType: String, Error {
    case serverError = "Server Error"
    case invalidData = "Invalid Data"
    case invalidURL = "Inlavid Url"
    case parsingError = "Data Parsing Error"
    case unknownError = "An error unknown"
}

class NetworkHelper {
    
    static let shared = NetworkHelper()
    
    private init() {}
    
}
