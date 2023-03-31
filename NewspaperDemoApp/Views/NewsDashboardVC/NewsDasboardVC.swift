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
    
    // MARK: - View Model
    lazy var viewModel: NewsViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NY Times Most Popular"
        self.setupCollectionView()
        self.setupViewModel()
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
    
    func setupViewModel() {
        viewModel.delegate = self
        viewModel.getAllNewsStories()
    }
}

// MARK: - News Collection View Delegate
extension NewsDasboardVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let newsDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsVC") as? NewsDetailsVC,
              let newsCellModel = self.viewModel.getNewsCellModel(for: indexPath)
        else { return }
        newsDetailsVC.model = newsCellModel
        self.navigationController?.pushViewController(newsDetailsVC, animated: true)
    }
}

// MARK: - News Collection View Data Source
extension NewsDasboardVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCell else {return UICollectionViewCell()}
        cell.configure(model: self.viewModel.getNewsCellModel(for: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        self.viewModel.minimumLineSpacingForSectionAt
    }
}

// MARK: - News Collection View Layout
extension NewsDasboardVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.getNewsCellSize(for: self.newsCollectionView.frame.size)
    }
}

// MARK: - View Model Delegate Methods
extension NewsDasboardVC: NewsViewModelDelegate {
    func setProgressHud(_ isHidden: Bool) {
        if isHidden {
            CustomHud.sharedInstance.hide()
        } else {
            CustomHud.sharedInstance.show()
        }
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.newsCollectionView.reloadData()
        }
    }
}
