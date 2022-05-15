//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Lev on 23.03.2022.
//

import UIKit

//protocol ProfileViewControllerDelegate: AnyObject {
//    func scroll()
//}

class ProfileViewController: UIViewController {
    
    //weak var delegate: ProfileViewControllerDelegate?

    private let post = Posts.makePost()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray5
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
           view.endEditing(true)
       }

}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count + 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
            return cell
        } else {


        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.setUpCell(self.post[indexPath.row - 1])
        return cell
       }
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let infoHeader = ProfileHeaderView()
//        if infoHeader.bigAvatar {
//            self.tableView.isScrollEnabled = true
//        } else {
//            self.tableView.isScrollEnabled = false
//        }
        //delegate?.scroll()
        infoHeader.delegate = self
        return infoHeader
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            let detailVC = PhotosViewController()
            navigationController?.pushViewController(detailVC, animated: true)
        } else {
            tableView.allowsSelection = false
        }
    }
}

//// MARK: - превью кода
//
//import SwiftUI
//
//struct SwiftUIController: UIViewControllerRepresentable {
//    
//    typealias UIViewControllerType = ProfileViewController
//    
//    func makeUIViewController(context: Context) -> ProfileViewController {
//        let viewController = UIViewControllerType()
//        return viewController
//    }
//    
//    func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) {
//    }
//}
//
//struct SwiftUIController_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIController().previewInterfaceOrientation(.portrait)
//    }
//}
