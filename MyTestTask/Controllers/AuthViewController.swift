//
//  ViewController.swift
//  MyTestTask
//
//  Created by Maksim Malofeev on 28/09/2022.
//

import UIKit

class AuthViewController: UIViewController {
    
    // MARK: - Prorerties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loginLable: UILabel = {
        let lable = UILabel()
        lable.text = "LogIn"
        lable.textColor = .label
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let singUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        button.setTitle("SingUp", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    private let singInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        button.setTitle("SingIn", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var textFieldsStackView = UIStackView()
    private var buttonsStackView = UIStackView()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupDelegate()
        setConstraints()
        regiterKeyboardNotification()
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        title = "SingIn"
        view.backgroundColor = .systemBackground
        singUpButton.addTarget(self, action: #selector(singUpButtonTapped), for: .touchUpInside)
        singInButton.addTarget(self, action: #selector(singInButtonTapped), for: .touchUpInside)


        
        textFieldsStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField],
                                          axis: .vertical,
                                          spacing: 10,
                                          distribution: .fillProportionally)
        
        buttonsStackView = UIStackView(arrangedSubviews: [singInButton, singUpButton],
                                       axis: .horizontal,
                                       spacing: 10,
                                       distribution: .fillEqually)
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(loginLable)
        backgroundView.addSubview(textFieldsStackView)
        backgroundView.addSubview(buttonsStackView)
    }
    
    private func setupDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func findUserDataBase(email: String) -> User? {
        let dataBase = DataBase.shared.users
        print(dataBase)
        var user: User?
        dataBase.forEach {
            if $0.email == email {
                user = $0
            }
        }
        return user
    }
    
    @objc func singUpButtonTapped() {
        let singUpViewController = SingUpViewController()
        self.present(singUpViewController, animated: true)
    }
    
    @objc func singInButtonTapped() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let user = findUserDataBase(email: email)
        
        if user == nil {
            loginLable.text = "User not found"
            loginLable.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else if user?.password == password {
            let navigationVC = UINavigationController(rootViewController: AlbumsViewController())
            navigationVC.modalPresentationStyle = .fullScreen
            self.present(navigationVC, animated: true)
            
            guard let activeUser = user else { return }
            DataBase.shared.saveActiveUser(user: activeUser)
        } else {
            loginLable.text = "Wrong password"
            loginLable.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }
}

// MARK: - UITextFieldDelegate

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

// MARK: - Add and remove Observer

extension AuthViewController {
    
    private func regiterKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: next)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: next)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardHeight = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight.height / 2)
    }
    
    @objc private func keyboardWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
}

// MARK: - SetConstraints

extension AuthViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            textFieldsStackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            textFieldsStackView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            textFieldsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            textFieldsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            
            loginLable.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            loginLable.bottomAnchor.constraint(equalTo: textFieldsStackView.topAnchor, constant: -30),
            
            singInButton.heightAnchor.constraint(equalToConstant: 40),
            singUpButton.heightAnchor.constraint(equalToConstant: 40),
            
            buttonsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            buttonsStackView.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 30),
            buttonsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20)
        ])
    }
}
