//
//  CustomTableViewCell.swift
//  Navigation
//
//  Created by Lev on 03.05.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    private let viewPost: UIView = {
        let viewPost = UIView()
        viewPost.translatesAutoresizingMaskIntoConstraints = false
        viewPost.backgroundColor = .white
        return viewPost
    }()
    
    private let imagePostView: UIImageView = {
        let imagePostView = UIImageView()
        imagePostView.translatesAutoresizingMaskIntoConstraints = false
        imagePostView.backgroundColor = .black
        imagePostView.contentMode = .scaleAspectFit
        return imagePostView
    }()
    
    private let authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        //authorLabel.backgroundColor = .green
        authorLabel.text = "AuthorLabel"
        authorLabel.font = UIFont.boldSystemFont(ofSize: 20)
        authorLabel.textColor = .black
        authorLabel.numberOfLines = 2
        return authorLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        //descriptionLabel.backgroundColor = .white
        descriptionLabel.text = "Description Label"
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    private let likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        //likesLabel.backgroundColor = .yellow
        likesLabel.text = "likes Label"
        likesLabel.font = UIFont.systemFont(ofSize: 16)
        likesLabel.textColor = .black
        return likesLabel
    }()
    
    private let viewsLabel: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        //viewsLabel.backgroundColor = .white
        viewsLabel.text = "views Label"
        viewsLabel.font = UIFont.systemFont(ofSize: 16)
        viewsLabel.textColor = .black
        return viewsLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
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
        [viewPost, imagePostView, authorLabel, descriptionLabel, likesLabel, viewsLabel].forEach { contentView.addSubview($0) }
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            viewPost.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            viewPost.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            viewPost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewPost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: viewPost.topAnchor, constant: inset),
            //authorLabel.heightAnchor.constraint(equalToConstant: 20),
            authorLabel.leadingAnchor.constraint(equalTo: viewPost.leadingAnchor, constant: inset),
            authorLabel.trailingAnchor.constraint(equalTo: viewPost.trailingAnchor, constant: -inset)
        ])
        
        NSLayoutConstraint.activate([
            imagePostView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: inset),
            //imagePostView.centerXAnchor.constraint(equalTo: viewPost.centerXAnchor),
            //imagePostView.centerYAnchor.constraint(equalTo: viewPost.centerYAnchor),
            imagePostView.leadingAnchor.constraint(equalTo: viewPost.leadingAnchor),
            imagePostView.trailingAnchor.constraint(equalTo: viewPost.trailingAnchor),
            imagePostView.heightAnchor.constraint(equalTo: viewPost.widthAnchor, multiplier: 1.0)
            //imagePostView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: imagePostView.bottomAnchor, constant: inset),
            //descriptionLabel.heightAnchor.constraint(equalToConstant: 50),
            descriptionLabel.leadingAnchor.constraint(equalTo: viewPost.leadingAnchor, constant: inset),
            descriptionLabel.trailingAnchor.constraint(equalTo: viewPost.trailingAnchor, constant: -inset)
        ])
        
        NSLayoutConstraint.activate([
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            //likesLabel.heightAnchor.constraint(equalToConstant: 20),
            //likesLabel.widthAnchor.constraint(equalToConstant: 100),
            likesLabel.leadingAnchor.constraint(equalTo: viewPost.leadingAnchor, constant: inset),
            likesLabel.bottomAnchor.constraint(equalTo: viewPost.bottomAnchor, constant: -inset)
        ])
        
        NSLayoutConstraint.activate([
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            //viewsLabel.heightAnchor.constraint(equalToConstant: 20),
            //viewsLabel.widthAnchor.constraint(equalToConstant: 100),
            viewsLabel.trailingAnchor.constraint(equalTo: viewPost.trailingAnchor, constant: -inset),
            viewsLabel.bottomAnchor.constraint(equalTo: viewPost.bottomAnchor, constant: -inset)
        ])
    }
}
