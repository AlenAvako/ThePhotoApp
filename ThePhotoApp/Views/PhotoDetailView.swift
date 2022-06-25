//
//  PhotoDetailView.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 24.06.2022.
//

import UIKit
import SDWebImage

protocol DetailViewDelegate: AnyObject {
    func closeView()
    
    func likeView(photo: Photo)
}

class PhotoDetailView: UIView {
    
    weak var delegate: DetailViewDelegate?
    
    var detailPhoto: Photo! {
        didSet {
            let photoURL = detailPhoto.urls["small"]
            guard let loadURL = photoURL, let url = URL(string: loadURL) else { return }
            photo.sd_setImage(with: url)
            guard let name = detailPhoto.user?.name else { return }
            nameLabel.text = "Name: \(name)"
            downloadsLabel.text = "Downloads: \(detailPhoto.downloads)"
            
            if detailPhoto.location != nil {
                guard let country = detailPhoto.location?.country, let city = detailPhoto.location?.city else { return }
                locationLabel.text = "Country: \(country) \nCity: \(city)"
            }
        }
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.addSubview(photo)
        view.addSubview(nameLabel)
        view.addSubview(downloadsLabel)
        view.addSubview(locationLabel)
        view.addSubview(likeView)
        return view
    }()
    
    private lazy var photo: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.clipsToBounds = true
        photo.contentMode = .scaleAspectFill
        return photo
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ABosaNova", size: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var downloadsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ABosaNova", size: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ABosaNova", size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dissmissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    private lazy var likeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.systemRed.cgColor
        view.layer.borderWidth = 3
        view.layer.cornerRadius = 30
        view.addSubview(likeImage)
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(changeState))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTapGesture)
        return view
    }()
    
    private lazy var likeImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .default)
        image.image = UIImage(systemName: "heart.fill", withConfiguration: largeConfig)
        image.tintColor = .systemRed
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(containerView)
        self.addSubview(dissmissButton)
        self.backgroundColor = .black
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func likeFlight() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .default)
            self.likeImage.image = UIImage(systemName: "heart.fill", withConfiguration: largeConfig)
            self.likeImage.tintColor = .white
            
            self.likeView.backgroundColor = .systemRed
        }, completion: nil)
    }
    
    func dislikeFlight() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .default)
            self.likeImage.image = UIImage(systemName: "heart.fill", withConfiguration: largeConfig)
            self.likeImage.tintColor = .systemRed
            
            self.likeView.backgroundColor = .white
        }, completion: nil)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            dissmissButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            dissmissButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 48),
            dissmissButton.heightAnchor.constraint(equalToConstant: 30),
            dissmissButton.widthAnchor.constraint(equalTo: dissmissButton.heightAnchor),

            photo.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            photo.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            photo.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            photo.heightAnchor.constraint(equalTo: photo.widthAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 12),

            downloadsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            downloadsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),

            locationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            locationLabel.topAnchor.constraint(equalTo: downloadsLabel.bottomAnchor, constant: 12),
            
            likeView.centerYAnchor.constraint(equalTo: photo.bottomAnchor),
            likeView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -48),
            likeView.heightAnchor.constraint(equalToConstant: 60),
            likeView.widthAnchor.constraint(equalTo: likeView.heightAnchor),
            
            likeImage.centerXAnchor.constraint(equalTo: likeView.centerXAnchor),
            likeImage.centerYAnchor.constraint(equalTo: likeView.centerYAnchor)
        ])
    }
    
    @objc private func changeState(_ tapGesture: UITapGestureRecognizer) {
        self.delegate?.likeView(photo: detailPhoto)
    }
    
    @objc private func close() {
        self.delegate?.closeView()
    }
}
