//
//  NewsDetailsVC.swift
//  NewspaperDemoApp
//
//  Created by Hassan Raza on 31/03/2023.
//

import UIKit

class NewsDetailsVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var autherNameLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    
    // MARK: - Model to configure data
    var model: NewsCellModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        
        guard let model = model else { return }
        self.configure(model: model)
    }
    
    private func configure(model: NewsCellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        autherNameLabel.text = model.authorName
        dateCreatedLabel.text = model.date
    }
    
}
