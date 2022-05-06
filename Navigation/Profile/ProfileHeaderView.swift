//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Lev on 31.03.2022.
//

import UIKit

final class ProfileHeaderView: UIView {
    
    private lazy var imageView: UIImageView = {
        let  imageView = UIImageView(image: UIImage(named: "dog"))
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = false// true???
        imageView.layer.cornerRadius = 80
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 10.0
        label.clipsToBounds = true
        label.text = "Cool dog"
        label.textColor = .black
        //label.font = UIFont(name: "Zapfino", size: 18)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 10.0
        label.text = "Waiting for something..."
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Write something..."
        textField.backgroundColor = .white
        textField.font = UIFont(name: "Helvetica-Regular", size: 15)
        textField.textColor = .black
        textField.layer.cornerRadius = 12.0
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.clipsToBounds = true
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.clearButtonMode = .unlessEditing
        textField.clearButtonMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 2))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change status", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .selected)
        
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 4.0
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.3
        button.addTarget(self, action: #selector(self.didTapStatusButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) error")
    }
    
    private func drawSelf() {
        
        self.addSubview(self.horizontalStackView)
        self.addSubview(self.statusButton)
        self.addSubview(self.textField)
        
        self.horizontalStackView.addArrangedSubview(self.imageView)
        self.horizontalStackView.addArrangedSubview(self.verticalStackView)
        
        self.verticalStackView.addArrangedSubview(self.nameLabel)
        self.verticalStackView.addArrangedSubview(self.statusLabel)
        //stack:
        let topConstraint = self.horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8)
        let leadingConstraint = self.horizontalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingConstraint = self.horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let heightConstraint = self.horizontalStackView.heightAnchor.constraint(equalToConstant: 160)
        //image:
        let imageViewAspectRatio = self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 1.0)
        //textField:
        let textFieldTopConstraint = self.textField.topAnchor.constraint(equalTo: self.horizontalStackView.bottomAnchor, constant: 10)
        let textFieldLeadingConstraint = self.textField.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor)
        let textFieldTrailingConstraint = self.textField.trailingAnchor.constraint(equalTo: self.horizontalStackView.trailingAnchor)
        let heightTextFieldConstraint = self.textField.heightAnchor.constraint(equalToConstant: 40)
        //button:
        let buttonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20)
        let leadingButtonConstraint = self.statusButton.leadingAnchor.constraint(equalTo: self.horizontalStackView.leadingAnchor)
        let trailingButtonConstraint = self.statusButton.trailingAnchor.constraint(equalTo: self.horizontalStackView.trailingAnchor)
        let heightButtonConstraint = self.statusButton.heightAnchor.constraint(equalToConstant: 50)
        let bottomButtonConstraint = self.statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        
        NSLayoutConstraint.activate([ textFieldTopConstraint, textFieldLeadingConstraint, textFieldTrailingConstraint, heightTextFieldConstraint])
        
        NSLayoutConstraint.activate([ heightConstraint, topConstraint, leadingConstraint, trailingConstraint, imageViewAspectRatio, buttonTopConstraint, leadingButtonConstraint, trailingButtonConstraint, heightButtonConstraint,bottomButtonConstraint])
        
    }
    
    private func changeStatus() {

        if ViewController.statusText == "" {
            statusLabel.text = "Write something..."
            self.statusButton.setTitle("Set status", for: .normal)
        } else {
            statusLabel.text = ViewController.statusText
            self.statusButton.setTitle("Change status", for: .normal)
        }
    }
    
    @objc private func didTapStatusButton() {
        
        ViewController.statusText = textField.text!
        
        UIView.animate(withDuration: 0.3, delay: 0.0) {
            
            self.changeStatus()
            
        } completion: { _ in
            
        }
    }
}

