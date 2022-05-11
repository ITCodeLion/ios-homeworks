//
//  CollectionCell.swift
//  Navigation
//
//  Created by Lev on 11.05.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private enum Constant {
        static let itemCount: CGFloat = 4
    }

    private let photosLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        label.text = "Photos"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()
    
    private lazy var arrowButton: UIImageView = {
            let image = UIImage(systemName: "arrow.right")
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
//    private lazy var stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.distribution = .fill
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
    
    private lazy var photoCollection: UICollectionView = {
        let photoLayout = UICollectionViewFlowLayout()
        photoLayout.scrollDirection = .horizontal
        let photoCollection = UICollectionView(frame: .zero, collectionViewLayout: photoLayout)
        photoCollection.dataSource = self
        photoCollection.delegate = self
        photoCollection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return photoCollection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        
//        self.backgroundColor = .systemGray6
//        stackView.addArrangedSubview(self.photosLabel)
//        stackView.addArrangedSubview(self.arrowButton)
        
        //[stackView, photoCollection].forEach { contentView.addSubview($0) }
        [photosLabel, arrowButton, photoCollection].forEach { contentView.addSubview($0) }
        
        let inset: CGFloat = 12
        
        NSLayoutConstraint.activate([
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset)
        ])
        
        NSLayoutConstraint.activate([
            arrowButton.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
        
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
//            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
//            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
//            stackView.heightAnchor.constraint(equalToConstant: 100),
//            self.arrowButton.centerYAnchor.constraint(equalTo: self.photosLabel.centerYAnchor)
//        ])
        
        NSLayoutConstraint.activate([
            photoCollection.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: inset),
            photoCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            photoCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            photoCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            photoCollection.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension PhotosTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupCell("f\([indexPath.item])")
        return cell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout

extension  PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    
    private var inset: CGFloat{ 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.bounds.width - inset * 3) / 4
        return CGSize(width: height, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        inset
    }
}
