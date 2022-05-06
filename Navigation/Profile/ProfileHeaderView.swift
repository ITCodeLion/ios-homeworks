//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Lev on 31.03.2022.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> ())
}

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
        textField.isHidden = true
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
        let textView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 2))
        textField.leftView = textView
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
    
    private var buttonTopConstraint: NSLayoutConstraint?
    
    weak var delegate: ProfileHeaderViewProtocol?
    
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
        
        let topConstraint = self.horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8)
        let leadingConstraint = self.horizontalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingConstraint = self.horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let heightConstraint = self.horizontalStackView.heightAnchor.constraint(equalToConstant: 160)
        
        let imageViewAspectRatio = self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 1.0)
        
        self.buttonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 16) //self.horizontalStackView.bottomAnchor
        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999)
        let leadingButtonConstraint = self.statusButton.leadingAnchor.constraint(equalTo: self.horizontalStackView.leadingAnchor)
        let trailingButtonConstraint = self.statusButton.trailingAnchor.constraint(equalTo: self.horizontalStackView.trailingAnchor)
        let heightButtonConstraint = self.statusButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([ heightConstraint, topConstraint, leadingConstraint, trailingConstraint, imageViewAspectRatio, self.buttonTopConstraint, leadingButtonConstraint, trailingButtonConstraint, heightButtonConstraint].compactMap( {$0 }))
        
    }
    
    private var statusText: String?
    
    @objc private func didTapStatusButton() {
        print("tap")
        let topConstraint = self.textField.topAnchor.constraint(equalTo: self.horizontalStackView.bottomAnchor, constant: 10)
        let leadingConstraint = self.textField.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor)
        let trailingConstraint = self.textField.trailingAnchor.constraint(equalTo: self.horizontalStackView.trailingAnchor)
        let heightTextFieldConstraint = self.textField.heightAnchor.constraint(equalToConstant: 40)
        
        if self.textField.isHidden {
            
            self.buttonTopConstraint?.isActive = false
            
            self.addSubview(self.textField)
            textField.text = nil  //???
            statusButton.setTitle("Set status", for: .normal)
            
            self.buttonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20)
            
            NSLayoutConstraint.activate([ topConstraint, leadingConstraint, trailingConstraint, heightTextFieldConstraint, self.buttonTopConstraint].compactMap( { $0 }))
            
            textField.becomeFirstResponder() // ??
            
        } else {
            
            statusText = textField.text!
            statusText == "" ? (statusLabel.text = "Write something...") : (statusLabel.text = statusText)

            statusButton.setTitle("Change status", for: .normal)
            self.textField.isHidden = false
            self.buttonTopConstraint?.isActive = false
            self.buttonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.horizontalStackView.bottomAnchor, constant: 16)
            NSLayoutConstraint.deactivate([topConstraint, leadingConstraint, trailingConstraint, heightTextFieldConstraint])
            self.textField.removeFromSuperview()
            NSLayoutConstraint.activate([ self.buttonTopConstraint].compactMap( { $0 }))
            
        }
        print("Status text \(String(describing: statusLabel.text))")
        self.delegate?.didTapStatusButton(textFieldIsVisible: self.textField.isHidden) { [weak self] in self?.textField.isHidden.toggle() }
    }
}

