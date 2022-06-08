//
//  LogInViewController.swift
//  Navigation
//
//  Created by Lev on 27.04.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    private let notCenter = NotificationCenter.default
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.backgroundColor = .systemGray6
        nameTextField.placeholder = "Email or phone number"
        nameTextField.font = UIFont.systemFont(ofSize: 16)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 2))
        nameTextField.leftView = leftView
        nameTextField.leftViewMode = .always
        nameTextField.autocapitalizationType = .none
        nameTextField.tintColor = .lightGray
        nameTextField.textColor = .black
        nameTextField.layer.borderWidth = 0.5
        nameTextField.layer.borderColor = UIColor.lightGray.cgColor
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.clearButtonMode = .unlessEditing
        nameTextField.clearButtonMode = .always
        nameTextField.delegate = self
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        return nameTextField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 16)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 2))
        passwordTextField.leftView = leftView
        passwordTextField.leftViewMode = .always
        passwordTextField.autocapitalizationType = .none
        passwordTextField.tintColor = .lightGray
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = .black
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.clearButtonMode = .unlessEditing
        passwordTextField.clearButtonMode = .always
        passwordTextField.delegate = self
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    }()
    
    private lazy var logInButton: UIButton = {
        let logInButton = UIButton()
        logInButton.setTitle("Log in", for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.layer.cornerRadius = 10
        logInButton.backgroundColor = UIColor(named: "Color")
        logInButton.translatesAutoresizingMaskIntoConstraints = false

        logInButton.addTarget(self, action: #selector(self.didTapLogInButton), for: .touchUpInside)
        
        return logInButton
    }()
    
    private lazy var logoImage: UIImageView = {
        let logoImage =  UIImageView()
        logoImage.image = UIImage(named: "logo")
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        return logoImage
    }()
    
    private lazy var textFieldStack: UIStackView = {
        let textFieldStack = UIStackView()
        textFieldStack.axis = .vertical
        textFieldStack.distribution = .fillEqually
        textFieldStack.spacing = 0
        textFieldStack.layer.cornerRadius = 10
        textFieldStack.clipsToBounds = true
        textFieldStack.layer.borderWidth = 0.5
        textFieldStack.layer.borderColor = UIColor.black.cgColor
        textFieldStack.translatesAutoresizingMaskIntoConstraints = false
        return textFieldStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        tapGesture()
        layout()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notCenter.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notCenter.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func kbdShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kbdSize.height * 1.4
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
        }
    }
    
    @objc private func kbdHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func layout() {
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])// widthAnchor.constraint needs!
        
        textFieldStack.addArrangedSubview(nameTextField)
        textFieldStack.addArrangedSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        [textFieldStack, logoImage, logInButton].forEach {contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  120),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textFieldStack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant:  120),
            textFieldStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textFieldStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textFieldStack.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: textFieldStack.bottomAnchor, constant:  16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    @objc private func didTapLogInButton(_ sender: UIButton) {
        sender.alpha = 0.5
        let profileVC = ProfileViewController()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { sender.alpha = 1.0
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
}

// MARK: - UITextFieldDelegate

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
