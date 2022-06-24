//
//  FavoriteCell.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 24.06.2022.
//

import UIKit

final class FavoriteCell: UITableViewCell {
    private lazy var photo: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        photo.clipsToBounds = true
        photo.contentMode = .scaleAspectFill
        photo.layer.cornerRadius = 20
        return photo
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        contentView.addSubview(photo)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        
            nameLabel.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 12),
            nameLabel.centerYAnchor.constraint(equalTo: photo.centerYAnchor)
        ])
    }
}
