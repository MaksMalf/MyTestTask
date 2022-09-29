//
//  SingUpViewController.swift
//  MyTestTask
//
//  Created by Maksim Malofeev on 29/09/2022.
//

import UIKit

class SingUpViewController: UIViewController {
    
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
        lable.text = "Registration"
        lable.textColor = .label
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "First Name"
        return textField
    }()
    
    private let firstNameValidLable: UILabel = {
        let lable = UILabel()
        lable.text = "Valid"
        lable.font = .systemFont(ofSize: 14)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()

    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Last Name"
        return textField
    }()
    
    private let lastNameValidLable: UILabel = {
        let lable = UILabel()
        lable.text = "Valid"
        lable.font = .systemFont(ofSize: 14)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()
    
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Age"
        return textField
    }()
    
    private let ageValidLable: UILabel = {
        let lable = UILabel()
        lable.text = "Valid"
        lable.font = .systemFont(ofSize: 14)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let phoneNumderTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Phone Number"
        return textField
    }()
    
    private let phoneNumderValidLable: UILabel = {
        let lable = UILabel()
        lable.text = "Valid"
        lable.font = .systemFont(ofSize: 14)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email"
        return textField
    }()
    
    private let emailValidLable: UILabel = {
        let lable = UILabel()
        lable.text = "Valid"
        lable.font = .systemFont(ofSize: 14)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        return textField
    }()
    
    private let passwordValidLable: UILabel = {
        let lable = UILabel()
        lable.text = "Valid"
        lable.font = .systemFont(ofSize: 14)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let singUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        button.setTitle("SingUp", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(singUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var elementsStackView = UIStackView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupToolbar()
        setupDelegate()
        setConstraints()
    }
    

    // MARK: - Private Methdos
    
    private func setupViews() {
        title = "SingUn"
        view.backgroundColor = .systemBackground
        
        elementsStackView = UIStackView(arrangedSubviews: [firstNameTextField,
                                                          firstNameValidLable,
                                                          lastNameTextField,
                                                          lastNameValidLable,
                                                          ageTextField,
                                                          ageValidLable,
                                                          phoneNumderTextField,
                                                          phoneNumderValidLable,
                                                          emailTextField,
                                                          emailValidLable,
                                                          passwordTextField,
                                                          passwordValidLable],
                                          axis: .vertical,
                                          spacing: 10,
                                          distribution: .fillProportionally)
        
        ageTextField.inputView = datePicker
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(elementsStackView)
        backgroundView.addSubview(loginLable)
        backgroundView.addSubview(singUpButton)
    }
    
    private func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexSpace, saveButton], animated: true)
        ageTextField.inputAccessoryView = toolbar
    }
    
    private func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        ageTextField.text = formatter.string(from: datePicker.date)
    }
    
    private func setupDelegate() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        ageTextField.delegate = self
        phoneNumderTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @objc func singUpButtonTapped() {
//        let singUpViewController = SingUpViewController()
//        self.present(singUpViewController, animated: true)
    }
    
    @objc func doneAction() {
        getDateFromPicker()
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension SingUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        phoneNumderTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

// MARK: - SetConstraints

extension SingUpViewController {
    
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
                        
            elementsStackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            elementsStackView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            elementsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            elementsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            
            loginLable.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            loginLable.bottomAnchor.constraint(equalTo: elementsStackView.topAnchor, constant: -30),
            
            singUpButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            singUpButton.topAnchor.constraint(equalTo: elementsStackView.bottomAnchor, constant: 30),
            singUpButton.heightAnchor.constraint(equalToConstant: 40),
            singUpButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}
