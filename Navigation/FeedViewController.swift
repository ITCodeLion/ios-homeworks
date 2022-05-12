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
        self.setupButtons()
    }
    
    private lazy var transitionButton: UIButton = {
        let button = UIButton(type: .system)
        settingButtons(button: button)
        return button
    }()
    
    private lazy var button2: UIButton = {
        let button = UIButton(type: .system)
        settingButtons(button: button)
        return button
    }()
    
    private func settingButtons (button: UIButton) {
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .systemYellow
        button.setTitle("Go to post", for: .normal)
        button.setTitleColor( .black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(didTapTransitionButton), for: .touchUpInside)
    }
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func setupButtons() {
        
        view.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            self.transitionButton.heightAnchor.constraint(equalToConstant: 50),
            self.button2.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        [transitionButton, button2].forEach { buttonStackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            self.buttonStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.buttonStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.buttonStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.buttonStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.buttonStackView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    @objc private func didTapTransitionButton() {
        let postVC = PostViewController()
        postVC.navigationItem.title = lastPost.title
        self.navigationController?.pushViewController(postVC, animated: true)
    }
}
