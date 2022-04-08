//
//  PostViewController.swift
//  Navigation
//
//  Created by Lev on 24.03.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    private lazy var myButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(didTapButton))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBrown
        self.navigationItem.rightBarButtonItem = myButton
        self.myButton.tintColor = .systemYellow
        self.navigationController?.navigationBar.tintColor = .systemYellow
    }
    
    @objc func didTapButton() {
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .fullScreen
        self.present(infoVC, animated: true)
    }
}
