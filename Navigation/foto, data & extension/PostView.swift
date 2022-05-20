//
//  PostView.swift
//  Navigation
//
//  Created by Lev on 18.05.2022.
//

import UIKit

class PostView: UIView {
    
    private let viewPost: UIView = {
        let viewPost = UIView()
        viewPost.translatesAutoresizingMaskIntoConstraints = false
        viewPost.backgroundColor = .white
        viewPost.clipsToBounds = true
        return viewPost
    }()
    
    private let imagePostView: UIImageView = {
        let imagePostView = UIImageView()
        imagePostView.translatesAutoresizingMaskIntoConstraints = false
        imagePostView.backgroundColor = .black
        imagePostView.contentMode = .scaleAspectFit
        imagePostView.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        return imagePostView
    }()
    
    private lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.text = "AuthorLabel"
        authorLabel.font = UIFont.boldSystemFont(ofSize: 20)
        authorLabel.textColor = .black
        authorLabel.numberOfLines = 2
        authorLabel.setContentCompressionResistancePriority(UILayoutPriority(999), for: .vertical)
        authorLabel.preferredMaxLayoutWidth = self.frame.size.width
        return authorLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Description Label"
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 0
        
        descriptionLabel.preferredMaxLayoutWidth = self.frame.size.width
        descriptionLabel.setContentCompressionResistancePriority(UILayoutPriority(999), for: .vertical)
        descriptionLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        
        return descriptionLabel
    }()
    
    private lazy var likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.text = "likes Label"
        likesLabel.font = UIFont.systemFont(ofSize: 16)
        likesLabel.textColor = .black
        
        likesLabel.preferredMaxLayoutWidth = self.frame.size.width
        likesLabel.textColor = .black
        likesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        likesLabel.setContentCompressionResistancePriority(UILayoutPriority(500), for: .horizontal)
        
        return likesLabel
    }()
    
    private lazy var viewsLabel: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsLabel.text = "views Label"
        viewsLabel.font = UIFont.systemFont(ofSize: 16)
        viewsLabel.textColor = .black
        
        viewsLabel.preferredMaxLayoutWidth = self.frame.size.width
        viewsLabel.setContentCompressionResistancePriority(UILayoutPriority(500), for: .vertical)
        
        return viewsLabel
    }()
    //
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.setContentCompressionResistancePriority(UILayoutPriority(999), for: .vertical)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var returnButton: UIButton = {
        let button = UIButton()
        //let image = UIImage(systemName: "clear")
        let image = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = .systemYellow
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(_ post: Posts) {
        imagePostView.image = post.image
        authorLabel.text = post.author
        descriptionLabel.text = post.description
        likesLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
    }
    
    private func layout() {
        [viewPost, returnButton].forEach { self.addSubview($0) }
        [imagePostView, authorLabel, descriptionLabel, stackView].forEach { self.viewPost.addSubview($0) }
        [likesLabel, viewsLabel].forEach { self.stackView.addArrangedSubview($0) }
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            viewPost.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            viewPost.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            viewPost.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewPost.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: viewPost.topAnchor, constant: inset),
            authorLabel.leadingAnchor.constraint(equalTo: viewPost.leadingAnchor, constant: inset),
            authorLabel.trailingAnchor.constraint(equalTo: viewPost.trailingAnchor, constant: -inset)
        ])
        
        NSLayoutConstraint.activate([
            imagePostView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: inset),
            imagePostView.leadingAnchor.constraint(equalTo: viewPost.leadingAnchor),
            imagePostView.trailingAnchor.constraint(equalTo: viewPost.trailingAnchor),
            imagePostView.heightAnchor.constraint(equalTo: viewPost.widthAnchor, multiplier: 1.0)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: imagePostView.bottomAnchor, constant: inset),
            descriptionLabel.leadingAnchor.constraint(equalTo: viewPost.leadingAnchor, constant: inset),
            descriptionLabel.trailingAnchor.constraint(equalTo: viewPost.trailingAnchor, constant: -inset)
        ])
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.viewPost.leadingAnchor, constant: inset),
            self.stackView.trailingAnchor.constraint(equalTo: self.viewPost.trailingAnchor, constant: -inset),
            self.stackView.bottomAnchor.constraint(equalTo: self.viewPost.bottomAnchor, constant: -inset)
        ])
        
        NSLayoutConstraint.activate([
            self.returnButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.returnButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            self.returnButton.heightAnchor.constraint(equalToConstant: 28),
            self.returnButton.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    @objc private func didTapButton() {
        removeFromSuperview()
    }
}

