//
//  NewsViewModel.swift
//  NewspaperDemoApp
//
//  Created by Hassan Raza on 31/03/2023.
//

import Foundation
import UIKit

protocol NewsViewModelDelegate: AnyObject {
    func reloadCollectionView()
    func setProgressHud(_ isHidden: Bool)
}

class NewsViewModel {
    
    // MARK: - Delegate
    weak var delegate: NewsViewModelDelegate?
    
    // MARK: - For Api Service
    private var newsApiService: NewsAPIService?
    
    // MARK: - News Cell Model
    var newsCellModel: [NewsCellModel]? {
        didSet {
            delegate?.reloadCollectionView()
        }
    }
    
    // MARK: - Variables
    var cellCount: Int {
        newsCellModel?.count ?? 0
    }
    
    let minimumLineSpacingForSectionAt: CGFloat = 30
    
    // MARK: - Constructor : Dependency Injection
    init(newsApiService: NewsAPIService = NewsApi()) {
        self.newsApiService = newsApiService
    }
}

// MARK: - Fetching News Data
extension NewsViewModel {
    func getAllNewsStories() {
        self.delegate?.setProgressHud(false)
        newsApiService?.fetchAll(callback: {[weak self] result in
            switch result {
            case .success(let newsDetails):
                var newsCellModel: [NewsCellModel] = []
                for news in newsDetails {
                    let newsModel = NewsCellModel(imageUrl: news.media?.first?.mediaMetadata?.first?.url ?? "",
                                                      title: news.title ?? "",
                                                      description: news.abstract ?? "",
                                                      authorName: news.auther ?? "",
                                                      date: news.publishedDate ?? "")
                    newsCellModel.append(newsModel)
                }
                self?.delegate?.setProgressHud(true)
                self?.newsCellModel = newsCellModel
            default:
                print("no item")
            }
        })
    }
}

// MARK: - Extention for News Cell Methods
extension NewsViewModel {
    // Return details for single NewsCell
    func getNewsCellModel(for indexPath: IndexPath) -> NewsCellModel? {
        let index = indexPath.item
        guard let newsCellModel = newsCellModel else {return nil}
        return newsCellModel[index]
    }
    
    // Calculate cell size for specified frame size
    func getNewsCellSize(for size: CGSize) -> CGSize {
        let width = size.width - 20
        var height = width / 4.5
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            height = width / 7
        }
        return CGSize(width: width, height: height)
    }
}
