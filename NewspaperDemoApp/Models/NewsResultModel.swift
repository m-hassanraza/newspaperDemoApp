//
//  NewsResultModel.swift
//  NewspaperDemoApp
//
//  Created by Hassan Raza on 31/03/2023.
//

import Foundation

// MARK: - News Result Model
struct NewsResultModel: Codable {

    var publishedDate: String?
    var title, abstract: String?
    var auther: String?
    var media: [NewsMediaModel]?

    enum CodingKeys: String, CodingKey {
        case publishedDate = "published_date"
        case title, abstract
        case auther = "byline"
        case media
    }
}
