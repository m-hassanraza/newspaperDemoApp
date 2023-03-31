//
//  NewsMediaModel.swift
//  NewspaperDemoApp
//
//  Created by Hassan Raza on 31/03/2023.
//

import Foundation

// MARK: - News Media Model
struct NewsMediaModel: Codable {
    var mediaMetadata: [NewsMediaMetadataModel]?

    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}
