//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Lev on 11.05.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    private lazy var photoCollection: UICollectionView = {
        let photoLayout = UICollectionViewFlowLayout()
        photoLayout.scrollDirection = .vertical
        let photoCollection = UICollectionView(frame: .zero, collectionViewLayout: photoLayout)
        photoCollection.dataSource = self
        photoCollection.delegate = self
        photoCollection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        photoCollection.translatesAutoresizingMaskIntoConstraints = false
        return photoCollection
    }()
    
    private func layout() {
        view.backgroundColor = .white
        view.addSubview(photoCollection)
        
        NSLayoutConstraint.activate([
            photoCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photoCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photoCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = .systemGray3
        self.navigationItem.title = "Photo Gallery"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

}

// MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupCell("f\(indexPath.item)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let zoomCell = ZoomCollectionPhoto()
        self.view.addSubview(zoomCell)
        zoomCell.photoZoomCell.image = UIImage(named: "f\(indexPath.item)")
        
        navigationController?.navigationBar.isHidden = true
        
        NSLayoutConstraint.activate([
            zoomCell.topAnchor.constraint(equalTo: view.topAnchor),
            zoomCell.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            zoomCell.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            zoomCell.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        UIView.animate(withDuration: 0.2, animations: {self.view.layoutIfNeeded()}) { _ in
            UIView.animate(withDuration: 0.5) {
                zoomCell.buttonCancel.isHidden = false
                zoomCell.buttonCancel.alpha = 1
                zoomCell.backgroundColor = .white.withAlphaComponent(0.9)
                
//                self.navigationItem.rightBarButtonItems = [
//                    UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(zoomCell.pressedButton))]
            }
        }
    }
}
// MARK: - UICollectionViewDelegateFlowLayout

extension  PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private var inset: CGFloat{ 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.bounds.width - inset * 4) / 3
        return CGSize(width: height, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        inset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        inset
    }
}
