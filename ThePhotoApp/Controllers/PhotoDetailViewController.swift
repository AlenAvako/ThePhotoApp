//
//  PhotoDetailViewController.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 24.06.2022.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    private var spinnerView: UIActivityIndicatorView = {
        let spinnerView = UIActivityIndicatorView(style: .large)
        return spinnerView
    }()
    
    private let detailView = PhotoDetailView()
    
    private let viewModel: DetailViewModel

    var checkPhoto = String() {
            didSet {
                if FavoriteManager.shared.checkPhotoStatus(photo: checkPhoto) {
                    detailView.likeFlight()
                } else {
                    detailView.dislikeFlight()
                }
            }
        }
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = detailView
        checkPhoto = viewModel.id
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.delegate = self
        
        setUpViewModel()
        setUpSpinnerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.makeRequest()
    }
    
    private func setUpViewModel() {
        viewModel.onStateChange = { [weak self] state in
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
                self.showContent()
                self.detailView.detailPhoto = self.viewModel.photo
            }
        }
    }
    
    private func showContent() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.detailView.alpha = 1
        }
    }
    
    private func hideContent() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.detailView.alpha = 0
        }
    }
    
    private func setUpSpinnerView() {
        view.addSubview(spinnerView)
        
        spinnerView.center = view.center
    }
}

extension PhotoDetailViewController: DetailViewDelegate {
    func likeView(photo: Photo) {
        let favoriteArray = FavoriteArray()
        if FavoriteManager.shared.checkPhotoStatus(photo: photo.id) {
            
            
            let alert = UIAlertController(title: "Warning", message: "delete from favorite?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .destructive) { [weak self] _ in
                self?.detailView.dislikeFlight()
                favoriteArray.deletePhoto(photo: photo)
                FavoriteManager.shared.removeFromFavorites(photo: photo.id)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(ok)
            alert.addAction(cancel)
            present(alert, animated: true)
        } else {
            FavoriteManager.shared.addToFavorites(photo: photo.id)
            detailView.likeFlight()
            favoriteArray.addPhoto(photo: photo)
        }
    }
    
    func closeView() {
        dismiss(animated: true)
    }
}
