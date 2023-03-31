//
//  ViewController.swift
//  NewspaperDemoApp
//
//  Created by Hassan Raza on 3/30/23.
//

import UIKit

class NewsDasboardVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NY Times Most Popular"
        self.setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newsCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func setupCollectionView() {
        // Setting up Delegate & Data Source
        self.newsCollectionView.delegate = self
        self.newsCollectionView.dataSource = self
        
        // Setting up Flow layout to scroll in vertical direction only
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 0, right: 10)
        self.newsCollectionView.setCollectionViewLayout(layout, animated: true)

        // Regiser NewsCell with newCollectionView
        let nib = UINib(nibName: "NewsCell", bundle: nil)
        self.newsCollectionView.register(nib, forCellWithReuseIdentifier: "NewsCell")
    }
    
}

extension NewsDasboardVC: UICollectionViewDelegate {
    
}

extension NewsDasboardVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCell else {return UICollectionViewCell()}
        print("Working")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        25
    }
    
}

extension NewsDasboardVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.newsCollectionView.frame.width - 20
        let height = width / 4.5
        return CGSize(width: width, height: height)
    }
}
