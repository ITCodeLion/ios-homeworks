//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Lev on 23.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupView()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Profile"
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemPink
        
    }
    
}
