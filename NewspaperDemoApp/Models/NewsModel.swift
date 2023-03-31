//
//  NewsModel.swift
//  NewspaperDemoApp
//
//  Created by Hassan Raza on 31/03/2023.
//

import Foundation

// MARK: - News Model
struct NewsModel: Codable {
    var status: String?
    var numResults: Int?
    var results: [NewsResultModel]?

    enum CodingKeys: String, CodingKey {
        case status
        case numResults = "num_results"
        case results
    }
}
