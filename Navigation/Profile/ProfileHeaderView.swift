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
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 50
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        imageView.isUserInteractionEnabled = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Cool dog"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
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
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
        self.tapAvatar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) error")
    }
    
    private var centerXImageAvaConstraint,
                    centerYImageAvaConstraint,
                    widthImageAvaConstraint,
                    heightImageAvaConstraint: NSLayoutConstraint?
    
    private func drawSelf() {
        
        [imageView, verticalStackView, statusButton, textField, blackView, crossButton ].forEach { self.addSubview($0) }
        
        self.verticalStackView.addArrangedSubview(self.nameLabel)
        self.verticalStackView.addArrangedSubview(self.statusLabel)
        
        // zoom avatar:
        self.centerXImageAvaConstraint = self.imageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 66)
        self.centerYImageAvaConstraint  = self.imageView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 66)
        self.widthImageAvaConstraint = self.imageView.widthAnchor.constraint(equalToConstant: 100)
        self.heightImageAvaConstraint = self.imageView.heightAnchor.constraint(equalToConstant: 100)
        
        NSLayoutConstraint.activate([
            self.centerXImageAvaConstraint,
            self.centerYImageAvaConstraint,
            self.widthImageAvaConstraint,
            self.heightImageAvaConstraint
        ].compactMap( {$0} ))
        
        //stack:
        NSLayoutConstraint.activate([
            self.verticalStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.verticalStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 132),
            self.verticalStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.verticalStackView.heightAnchor.constraint(equalToConstant: 100)
        ])

        //textField:
        NSLayoutConstraint.activate([
            self.textField.topAnchor.constraint(equalTo: self.verticalStackView.bottomAnchor, constant: 10),
            self.textField.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor),
            self.textField.trailingAnchor.constraint(equalTo: self.verticalStackView.trailingAnchor),
            self.textField.heightAnchor.constraint(equalToConstant: 40)
        ])

        //button:
        NSLayoutConstraint.activate([
            self.statusButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 16),
            self.statusButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.statusButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.statusButton.heightAnchor.constraint(equalToConstant: 50),
            self.statusButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // blackView:
        NSLayoutConstraint.activate([
            self.blackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
            self.blackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height)
        ])
        
        self.blackView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        
        self.imageView.layer.zPosition = 1
        
        NSLayoutConstraint.activate([
            self.crossButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.crossButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            self.crossButton.heightAnchor.constraint(equalToConstant: 40),
            self.crossButton.widthAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    private func changeStatus() {

        if ViewController.statusText == "" {
            self.textField.vibro()
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
    
// MARK: - for animate avatar:
    weak var delegate: ProfileViewController?
    
    private var blackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    private lazy var crossButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = .systemYellow
        button.isHidden = true
        button.alpha = 0
        button.addTarget(self, action: #selector(self.closeAvatar), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    private func tapAvatar() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAvatar))
        self.imageView.addGestureRecognizer(tap)
    }
    
    @objc private func didTapAvatar() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.blackView.isHidden = false
            self.blackView.alpha = 0.6
            
            self.imageView.layer.cornerRadius = 0
            self.crossButton.isHidden = false
            
            NSLayoutConstraint.deactivate([
                self.centerXImageAvaConstraint,
                self.centerYImageAvaConstraint,
                self.widthImageAvaConstraint,
                self.heightImageAvaConstraint
            ].compactMap( {$0} ))
            
            let superViewFrame = (self.superview?.safeAreaLayoutGuide.layoutFrame)!
            
            self.centerXImageAvaConstraint?.constant = superViewFrame.width / 2
            self.centerYImageAvaConstraint?.constant = superViewFrame.height / 2
            
            let avatarWidth: CGFloat
            if superViewFrame.width < superViewFrame.height {
                avatarWidth = superViewFrame.width
            } else {
                avatarWidth = superViewFrame.height
            }
            self.widthImageAvaConstraint?.constant = avatarWidth
            self.heightImageAvaConstraint?.constant = avatarWidth
            
            NSLayoutConstraint.activate([
                self.centerXImageAvaConstraint,
                self.centerYImageAvaConstraint,
                self.widthImageAvaConstraint,
                self.heightImageAvaConstraint
            ].compactMap( {$0} ))
            
            self.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                //self.bigAvatar = true
                self.delegate?.tableView.isScrollEnabled = false
                self.crossButton.alpha = 1
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc private func closeAvatar() {
        UIView.animate(withDuration: 0.5, animations: {
            
            NSLayoutConstraint.deactivate([
                self.centerXImageAvaConstraint,
                self.centerYImageAvaConstraint,
                self.widthImageAvaConstraint,
                self.heightImageAvaConstraint
            ].compactMap( {$0} ))
            
            self.centerXImageAvaConstraint = self.imageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 66)
            self.centerYImageAvaConstraint  = self.imageView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 66)
            self.widthImageAvaConstraint = self.imageView.widthAnchor.constraint(equalToConstant: 100)
            self.heightImageAvaConstraint = self.imageView.heightAnchor.constraint(equalToConstant: 100)
            
            NSLayoutConstraint.activate([
                self.centerXImageAvaConstraint,
                self.centerYImageAvaConstraint,
                self.widthImageAvaConstraint,
                self.heightImageAvaConstraint
            ].compactMap( {$0} ))
            
            //self.bigAvatar = false
            self.imageView.layer.cornerRadius = 50
            self.crossButton.alpha = 0
            self.blackView.alpha = 0
            self.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 1) {
                self.delegate?.tableView.isScrollEnabled = true
                
                self.blackView.isHidden = true
                self.crossButton.isHidden = true
            }
        }
    }
}
