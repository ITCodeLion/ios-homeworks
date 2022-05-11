//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Lev on 07.05.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    private lazy var photoImageView: UIImageView = {
        let photoImage = UIImageView()
        photoImage.layer.cornerRadius = 6
        photoImage.contentMode = .scaleAspectFill
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        photoImage.backgroundColor = .white
        photoImage.clipsToBounds = true
        return photoImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func customizeCell() {
        contentView.backgroundColor = .black
        
        contentView.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupCell(_ photo: String) {
        photoImageView.image = UIImage(named: photo)
    }
}
