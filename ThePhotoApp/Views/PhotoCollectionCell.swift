//
//  PhotoCollectionCell.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 23.06.2022.
//

import UIKit
import SDWebImage

final class PhotoCollectionCell: UICollectionViewCell {
    
    var loadedPhoto: PhotoCollection! {
        didSet {
            let photoURL = loadedPhoto.urls["small"]
            guard let searchURL = photoURL, let url = URL(string: searchURL) else { return }
            photo.sd_setImage(with: url)
        }
    }
    
    private lazy var photo: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.clipsToBounds = true
        photo.contentMode = .scaleAspectFill
        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photo.image = nil
    }
    
    private func setUpConstraints() {
        contentView.addSubview(photo)
        
        NSLayoutConstraint.activate([
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
