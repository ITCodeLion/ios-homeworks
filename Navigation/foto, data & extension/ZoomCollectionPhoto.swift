//
//  zoomCollectionPhoto.swift
//  Navigation
//
//  Created by Lev on 20.05.2022.
//

import UIKit

class ZoomCollectionPhoto: UIView {
    
    lazy var photoZoomCell: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFit
        photo.clipsToBounds = true
        photo.backgroundColor = .black
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()
    
    lazy var buttonCancel: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = .systemYellow
        button.isHidden = true
        button.alpha = 0
        button.addTarget(self, action: #selector(self.pressedButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
       
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(photoZoomCell)
        self.addSubview(buttonCancel)
        
        NSLayoutConstraint.activate([
            photoZoomCell.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            photoZoomCell.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            photoZoomCell.widthAnchor.constraint(equalTo: self.widthAnchor),
            photoZoomCell.heightAnchor.constraint(equalTo: self.widthAnchor),
            buttonCancel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            buttonCancel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buttonCancel.widthAnchor.constraint(equalToConstant: 30),
            buttonCancel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

//    @objc func pressedButton() {
//        self.removeFromSuperview()
//    }
    
    weak var delegate: ZoomCollectionPhotoDelegate?
    
    @objc func pressedButton() {
        delegate?.didCloseZoom(view: self)
    }

}

protocol ZoomCollectionPhotoDelegate: AnyObject {
    func didCloseZoom(view: ZoomCollectionPhoto)
}
