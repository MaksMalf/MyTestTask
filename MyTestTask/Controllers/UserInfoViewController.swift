//
//  UserInfoViewController.swift
//  MyTestTask
//
//  Created by Maksim Malofeev on 29/09/2022.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    private let firstNameLable: UILabel = {
        let lable = UILabel()
        lable.text = "First Name"
        lable.textColor = .label
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let lastNameLable: UILabel = {
        let lable = UILabel()
        lable.text = "Last Name"
        lable.textColor = .label
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let ageLable: UILabel = {
        let lable = UILabel()
        lable.text = "Age"
        lable.textColor = .label
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let phoneLable: UILabel = {
        let lable = UILabel()
        lable.text = "Phone"
        lable.textColor = .label
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let emailLable: UILabel = {
        let lable = UILabel()
        lable.text = "Email"
        lable.textColor = .label
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let passwordLable: UILabel = {
        let lable = UILabel()
        lable.text = "Password"
        lable.textColor = .label
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private var stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setConstraints()
    }
    

    private func setupView() {
        
        title = "Active User"
        view.backgroundColor = .systemBackground
        
        stackView = UIStackView(arrangedSubviews: [firstNameLable,
                                                  lastNameLable,
                                                  ageLable,
                                                  phoneLable,
                                                  emailLable,
                                                  passwordLable],
                                axis: .vertical,
                                spacing: 20,
                                distribution: .fillProportionally)
        view.addSubview(stackView)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
