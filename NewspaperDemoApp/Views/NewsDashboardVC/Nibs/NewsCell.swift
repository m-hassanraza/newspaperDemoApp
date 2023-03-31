//
//  NewsCell.swift
//  NewspaperDemoApp
//
//  Created by Hassan Raza on 31/03/2023.
//

import UIKit
import SDWebImage

class NewsCell: UICollectionViewCell {

    // MARK: Outlets
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var autherNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(model: NewsCellModel?) {
        guard let model = model else { return }
        let url = URL(string: model.imageUrl)
        let placeholderImage = UIImage(named: "PlaceholderImage")
        thumbnailImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        thumbnailImage.sd_setImage(with: url, placeholderImage: placeholderImage, context: nil)
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        autherNameLabel.text = model.authorName
        dateLabel.text = model.date
    }
}
