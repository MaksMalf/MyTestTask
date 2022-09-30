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
        lable.font = .systemFont(ofSize: 14)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let phoneNumderTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Phone Number"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let phoneNumderValidLable: UILabel = {
        let lable = UILabel()
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
    let nameValidType: String.ValidTypes = .name
    let emailValidType: String.ValidTypes = .email
    let passwordValidType: String.ValidTypes = .password

    
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
        regiterKeyboardNotification()
    }
    
    deinit {
        removeKeyboardNotification()
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
    
    private func set(textField: UITextField,
                     lable: UILabel,
                     validType: String.ValidTypes,
                     validMessage: String,
                     wrongMessage: String,
                     replacementString string: String,
                     range: NSRange) {
        
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        
        if result.isValid(validType: validType) {
            lable.text = validMessage
            lable.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        } else {
            lable.text = wrongMessage
            lable.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }
    
    private func setPhoneNumber(mask: String, replacementString string: String, range: NSRange) -> String {
        
        let text = phoneNumderTextField.text ?? ""
        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "*" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        
        if result.count == 18 {
            phoneNumderValidLable.text = "Phone is valid"
            phoneNumderValidLable.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        } else {
            phoneNumderValidLable.text = "Phone is not valid"
            phoneNumderValidLable.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
        
        return result
    }
    
    private func ageIsValid() -> Bool {
        let calender = NSCalendar.current
        let dateNow = Date()
        let birthday = datePicker.date
        
        let age = calender.dateComponents([.year], from: birthday, to: dateNow)
        let ageYear = age.year
        
        guard let ageYear else { return false }
        return ageYear < 18 ? false : true
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case firstNameTextField: set(textField: textField,
                                     lable: firstNameValidLable,
                                     validType: nameValidType,
                                     validMessage: "Name is valid",
                                     wrongMessage: "Use only A-Z characters, min 1 character",
                                     replacementString: string,
                                     range: range)
        case lastNameTextField: set(textField: textField,
                                    lable: lastNameValidLable,
                                    validType: nameValidType,
                                    validMessage: "Name is valid",
                                    wrongMessage: "Use only A-Z characters, min 1 character",
                                    replacementString: string,
                                    range: range)
        case emailTextField: set(textField: textField,
                                 lable: emailValidLable,
                                 validType: emailValidType,
                                 validMessage: "Email is valid",
                                 wrongMessage: "Email is not valid",
                                 replacementString: string,
                                 range: range)
        case passwordTextField: set(textField: textField,
                                 lable: passwordValidLable,
                                 validType: passwordValidType,
                                 validMessage: "Password is valid",
                                 wrongMessage: "Password is not valid",
                                 replacementString: string,
                                 range: range)
        case phoneNumderTextField: phoneNumderTextField.text = setPhoneNumber(mask: "+* (***) ***-**-**",
                                                                              replacementString: string,
                                                                              range: range)
        default:
            break
        }
        
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        phoneNumderTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

// MARK: - Add and remove Observer

extension SingUpViewController {
    
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
