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
    
    //This is for password verification:
    
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите 6 или больше символов"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var topButtonConstraint: NSLayoutConstraint?
    
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
        ])
        
        textFieldStack.addArrangedSubview(nameTextField)
        textFieldStack.addArrangedSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        [textFieldStack, logoImage, logInButton, warningLabel].forEach {contentView.addSubview($0)}
        
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
        
        // for change button:
        self.topButtonConstraint = logInButton.topAnchor.constraint(equalTo: textFieldStack.bottomAnchor, constant:  16)
        
        self.topButtonConstraint?.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            topButtonConstraint,
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].compactMap({$0}))
        
    }
    
    // for check password and login:
    private func passwordValid(_ password: String) -> Bool {
        let passwordReg = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{6}$" //"(?=.*[0-9]).{1}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordReg)
        return passwordTest.evaluate(with: password)
    }
    //
    private func emailValid(_ email: String) -> Bool {
        let emailReg = ".{6,}" //"(?=.*[0-9]).{1}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailReg)
        return emailTest.evaluate(with: email)
    }
    
    @objc private func didTapLogInButton(_ sender: UIButton) {
        sender.alpha = 0.5
        
        let topLabelConstraint = self.warningLabel.topAnchor.constraint(equalTo: self.textFieldStack.bottomAnchor, constant: 16)
        let heightLabelConstraint = self.warningLabel.heightAnchor.constraint(equalToConstant: 40)
        let leadingLabelConstraint = self.warningLabel.leadingAnchor.constraint(equalTo: self.textFieldStack.leadingAnchor)
        let trailingLabelConstraint = self.warningLabel.trailingAnchor.constraint(equalTo: self.textFieldStack.trailingAnchor)
        
        self.topButtonConstraint = self.logInButton.topAnchor.constraint(equalTo: self.warningLabel.bottomAnchor, constant: 16)
        
        if !emailValid(nameTextField.text!) {
            let alert = UIAlertController(title: "Внимание!", message: "Некорректный email.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok!", style: UIAlertAction.Style.default, handler: {_ in
                sender.alpha = 1.0
                self.nameTextField.backgroundColor = .white
                self.passwordTextField.backgroundColor = .white
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        if !passwordValid(passwordTextField.text!){
            self.warningLabel.isHidden = false
            contentView.addSubview(self.warningLabel)
            self.topButtonConstraint?.isActive = false
            NSLayoutConstraint.activate([topLabelConstraint, heightLabelConstraint, leadingLabelConstraint, trailingLabelConstraint, topButtonConstraint].compactMap({$0}))
        } else {
            self.warningLabel.removeFromSuperview()
            NSLayoutConstraint.deactivate([topLabelConstraint, heightLabelConstraint, leadingLabelConstraint, trailingLabelConstraint])
            self.warningLabel.isHidden = true
        }
        
        switch "" {
        case nameTextField.text!:
            nameTextField.backgroundColor = .red
        case passwordTextField.text!:
            passwordTextField.backgroundColor = .red
        default:
            break
        }
        // "dog@mail.com" & "Qwerty1$"
        if self.nameTextField.text! == "dog@mail.com" && self.passwordTextField.text! == "Qwerty1$" {
            let profileVC = ProfileViewController()
            self.navigationController?.pushViewController(profileVC, animated: true)
        } else {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                sender.alpha = 1.0
//                self.nameTextField.backgroundColor = .white
//                self.passwordTextField.backgroundColor = .white
//
//                //self.navigationController?.pushViewController(profileVC, animated: true)
//            }
            //sleep(1)
            let alert = UIAlertController(title: "Внимание!", message: "Не корректный логин или пороль", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok!", style: UIAlertAction.Style.default, handler: {_ in 
                sender.alpha = 1.0
                self.nameTextField.backgroundColor = .white
                self.passwordTextField.backgroundColor = .white
            }))
            self.present(alert, animated: true, completion: nil )
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
