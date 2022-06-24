//
//  PhotoCollectionViewController.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 23.06.2022.
//

import UIKit

class PhotoCollectionViewController: UIViewController {
    
    private lazy var photoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let photoCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photoCollection.translatesAutoresizingMaskIntoConstraints = false
        photoCollection.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: String(describing: PhotoCollectionCell.self))
        photoCollection.backgroundColor = .cyan
        photoCollection.alpha = 0
        return photoCollection
    }()
    
    private lazy var spinnerView: UIActivityIndicatorView = {
        spinnerView = UIActivityIndicatorView(style: .large)
        return spinnerView
    }()
    
    private let viewModel: CollectionViewModel
    
    init(viewModel: CollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        
        setUpSpinnerView()
        setUpCollectionView()
        setUpViewModel()
        
        viewModel.makeRequest()
    }
    
    private func setUpViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initilazing:
                self.spinnerView.startAnimating()
                self.hideContent()
            case . loading:
                self.spinnerView.startAnimating()
                self.hideContent()
            case .loaded:
                self.spinnerView.stopAnimating()
                self.photoCollection.reloadData()
                self.showContent()
            }
        }
    }
    
    private func showContent() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.photoCollection.alpha = 1
        }
    }
    
    private func hideContent() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.photoCollection.alpha = 0
        }
    }
    
    private func setUpSpinnerView() {
        view.addSubview(spinnerView)
        
        spinnerView.center = view.center
    }
    
    private func setUpCollectionView() {
        view.addSubview(photoCollection)
        
        photoCollection.dataSource = self
        photoCollection.delegate = self
        
        NSLayoutConstraint.activate([
            photoCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photoCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photoCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PhotoCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCollectionCell.self), for: indexPath) as! PhotoCollectionCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 10 * (itemsPerRow + 1)
        let accessibleWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = accessibleWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
}
