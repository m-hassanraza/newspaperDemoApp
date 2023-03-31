//
//  NewsViewModel.swift
//  NewspaperDemoApp
//
//  Created by Hassan Raza on 31/03/2023.
//

import Foundation

class NewsViewModel {
    
    private var newsApiService: NewsAPIService?
    
    init(newsApiService: NewsAPIService = NewsApi()) {
        self.newsApiService = newsApiService
    }
    
    func getAllNewsStories(callback: @escaping NewsAPIService.GetNewsCallback) {
        newsApiService?.fetchAll(callback: callback)
    }
    
    func getTopStories(callback: @escaping ([NewsCellModel]) -> Void) {
        var newsCellViewModel: [NewsCellModel] = []
        
        self.getAllNewsStories { result in
            switch result {
            case .success(let newsDetails):
                for news in newsDetails {
                    let newsModel = NewsCellModel(imageUrl: news.media?.first?.mediaMetadata?.first?.url ?? "",
                                                      title: news.title ?? "",
                                                      description: news.abstract ?? "",
                                                      authorName: news.auther ?? "",
                                                      date: news.publishedDate ?? "")
                    newsCellViewModel.append(newsModel)
                }
                callback(newsCellViewModel)
            default:
                print("no item")
            }
        }
    }
}
