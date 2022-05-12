//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Lev on 23.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let post = Posts.makePost()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray5
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        layout()
        self.setupNavigationBar()
        self.tapGesture()
    }
    
    private func layout() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
// MARK: - NavigationBar and tapGesture for keyboard
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        var context: UIListContentConfiguration = cell.defaultContentConfiguration()
//        context.text = "Секция = \(indexPath.section), ячейка = \(indexPath.row)"
//        context.image = post[indexPath.row].image
//        //context.imageToTextPadding
//        cell.contentConfiguration = context
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.setUpCell(self.post[indexPath.row])
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return UIScreen.main.bounds.width
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let infoHeader = ProfileHeaderView()
        return infoHeader
    }
}
