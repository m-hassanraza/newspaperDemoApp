//
//  APIService.swift
//  NewspaperDemoApp
//
//  Created by Hassan Raza on 31/03/2023.
//

import Foundation

protocol NewsAPIService {
    typealias GetNewsCallback = (Result<[NewsResultModel], Error>) -> Void
    func fetchAll(callback: @escaping GetNewsCallback)
}

class NewsApi: NewsAPIService {
    func fetchAll(callback: @escaping GetNewsCallback) {
        
        // API URL
        guard let url = URL(string: Constants.baseUrl + Constants.mostPopularArticals + Constants.apiKey) else { return }
        
        // Variables
        var news: [NewsResultModel] = []
        
        // Header
//        let header = [
//            "Authorization" : Keys.authKey
//        ]
        
        // URL Request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
//        urlRequest.allHTTPHeaderFields = header
        
        // Request
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                print("Error: ", error)
                return
            }
            
            if let data = data {
                guard let newsModel = try? JSONDecoder().decode(NewsModel.self, from: data) else { return }
                news = newsModel.results ?? []
                callback(.success(news))
                
            }
        }
        
        task.resume()
        
    }
}

class NewsApiMock: NewsAPIService {
    func fetchAll(callback: @escaping GetNewsCallback) {
        // return photos via callback
    }
}
