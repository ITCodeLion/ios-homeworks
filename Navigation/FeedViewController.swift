//
//  FeedViewController.swift
//  Navigation
//
//  Created by Lev on 24.03.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private struct Post {
        var title: String
    }
    
    private let lastPost = Post.init(title: "My post")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigatiomBar()
        self.setupView()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    private func setupNavigatiomBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Feed"
    }
    
    private func setupView() {
        self.view.backgroundColor = .purple
        self.view.addSubview(self.transitionButton)
        self.setupButton()
    }
    
    private lazy var transitionButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .systemYellow
        button.setTitle("Go to post", for: .normal)
        button.setTitleColor( .black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupButton() {
        transitionButton.addTarget(self, action: #selector(didTapTransitionButton), for: .touchUpInside)
        self.transitionButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.transitionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        self.transitionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        self.transitionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc private func didTapTransitionButton() {
        let postVC = PostViewController()
        postVC.navigationItem.title = lastPost.title
        self.navigationController?.pushViewController(postVC, animated: true)
    }
}
