//
//  HelperAccountViewController.swift
//  SaveElderProject
//
//  Created by Demian on 2020/01/17.
//  Copyright © 2020 Demian. All rights reserved.
//

import UIKit
import Firebase
class HelperAccountViewController: UIViewController {
    
        //MARK: 변수 선언
    var accountFieldView = UIView()
    var elderInfoFieldView = UIView()
    var accountLabel = UILabel()
    var elderInfoLabel = UILabel()
    var userIDUpperLabel = UILabel()
    var userIDLabel = UILabel()
    var userEmail = ""
    var inviteCodeUpperLabel = UILabel()
    var inviteCodeLabel = UILabel()
    var inviteCode = ""
    var elderNameUpperLabel = UILabel()
    var elderNameLabel = UILabel()
    var elderName = ""
    var elderPhoneNumberUpperLabel = UILabel()
    var elderPhoneNumberLabel = UILabel()
    var elderPhoneNumber = ""
    var logOutButton = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "mercury")
        setupUINew()
    }
    
    private func setupUINew() {
        accountFieldView.layer.cornerRadius = 4
        accountFieldView.backgroundColor = .white
        accountFieldView.shadow()
        view.addSubview(accountFieldView)
        elderInfoFieldView.layer.cornerRadius = 4
        elderInfoFieldView.backgroundColor = .white
        elderInfoFieldView.shadow()
        view.addSubview(elderInfoFieldView)
        accountLabel.text = "회원 정보"
        accountLabel.textColor = .darkGray
        accountLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        accountLabel.textAlignment = .left
        accountFieldView.addSubview(accountLabel)
        userIDUpperLabel.text = "가입 이메일"
        userIDUpperLabel.textColor = .darkGray
        userIDUpperLabel.font = UIFont.preferredFont(forTextStyle: .body)
        userIDUpperLabel.textAlignment = .left
        accountFieldView.addSubview(userIDUpperLabel)
        userIDLabel.text = userEmail
        userIDLabel.textColor = .black
        userIDLabel.font = UIFont.preferredFont(forTextStyle: .body)
        userIDLabel.textAlignment = .left
        accountFieldView.addSubview(userIDLabel)
        inviteCodeUpperLabel.text = "초대 코드"
        inviteCodeUpperLabel.textColor = .darkGray
        inviteCodeUpperLabel.font = UIFont.preferredFont(forTextStyle: .body)
        inviteCodeUpperLabel.textAlignment = .left
        accountFieldView.addSubview(inviteCodeUpperLabel)
        inviteCodeLabel.text = inviteCode
        inviteCodeLabel.textColor = .black
        inviteCodeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        inviteCodeLabel.textAlignment = .left
        accountFieldView.addSubview(inviteCodeLabel)
        elderInfoLabel.text = "피보호자 정보"
        elderInfoLabel.textColor = .darkGray
        elderInfoLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        elderInfoLabel.textAlignment = .left
        elderInfoFieldView.addSubview(elderInfoLabel)
        elderNameUpperLabel.text = "피보호자 이름"
        elderNameUpperLabel.textColor = .darkGray
        elderNameUpperLabel.font = UIFont.preferredFont(forTextStyle: .body)
        elderNameUpperLabel.textAlignment = .left
        elderInfoFieldView.addSubview(elderNameUpperLabel)
        elderNameLabel.text = elderName
        elderNameLabel.textColor = .black
        elderNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        elderNameLabel.textAlignment = .left
        elderInfoFieldView.addSubview(elderNameLabel)
        elderPhoneNumberUpperLabel.text = "피보호자 연락처"
        elderPhoneNumberUpperLabel.textColor = .darkGray
        elderPhoneNumberUpperLabel.font = UIFont.preferredFont(forTextStyle: .body)
        elderPhoneNumberUpperLabel.textAlignment = .left
        elderInfoFieldView.addSubview(elderPhoneNumberUpperLabel)
        elderPhoneNumberLabel.text = elderPhoneNumber
        elderPhoneNumberLabel.textColor = .black
        elderPhoneNumberLabel.font = UIFont.preferredFont(forTextStyle: .body)
        elderPhoneNumberLabel.textAlignment = .left
        elderInfoFieldView.addSubview(elderPhoneNumberLabel)
        logOutButton.backgroundColor = .white
        logOutButton.layer.borderColor = UIColor.red.cgColor
        logOutButton.layer.borderWidth = 1
        logOutButton.layer.cornerRadius = 8
        logOutButton.setTitle("로그아웃", for: .normal)
        logOutButton.setTitleColor(.red, for: .normal)
        logOutButton.addTarget(self, action: #selector(didTapLogoutButton(_:)), for: .touchUpInside)
        view.addSubview(logOutButton)
        setupConstraintsNew()
    }
    
    private func setupConstraintsNew() {
        accountFieldView.layout.top(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        accountFieldView.leading(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        accountFieldView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        accountFieldView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        accountLabel.layout.top(equalTo: accountFieldView.topAnchor, constant: 20)
        accountLabel.leading(equalTo: accountFieldView.leadingAnchor, constant: 30)
        userIDUpperLabel.layout.top(equalTo: accountLabel.bottomAnchor, constant: 40)
        userIDUpperLabel.leading(equalTo: accountLabel.leadingAnchor, constant: 5)
        userIDLabel.layout.top(equalTo: userIDUpperLabel.bottomAnchor, constant: 10)
        userIDLabel.leading(equalTo: userIDUpperLabel.leadingAnchor, constant: 0)
        inviteCodeUpperLabel.layout.top(equalTo: userIDLabel.bottomAnchor, constant: 30)
        inviteCodeUpperLabel.leading(equalTo: userIDUpperLabel.leadingAnchor, constant: 0)
        inviteCodeLabel.layout.top(equalTo: inviteCodeUpperLabel.bottomAnchor, constant: 10)
        inviteCodeLabel.leading(equalTo: userIDUpperLabel.leadingAnchor, constant: 0)
        elderInfoFieldView.layout.top(equalTo: accountFieldView.bottomAnchor, constant: 20)
        elderInfoFieldView.layout.leading(constant: 20)
        elderInfoFieldView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        elderInfoFieldView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        elderInfoLabel.layout.top(equalTo: elderInfoFieldView.topAnchor, constant: 20)
        elderInfoLabel.leading(equalTo: elderInfoFieldView.leadingAnchor, constant: 30)
        elderNameUpperLabel.layout.top(equalTo: elderInfoLabel.bottomAnchor, constant: 40)
        elderNameUpperLabel.leading(equalTo: elderInfoLabel.leadingAnchor, constant: 5)
        elderNameLabel.layout.top(equalTo: elderNameUpperLabel.bottomAnchor, constant: 10)
        elderNameLabel.leading(equalTo: elderNameUpperLabel.leadingAnchor, constant: 0)
        elderPhoneNumberUpperLabel.layout.top(equalTo: elderNameLabel.bottomAnchor, constant: 40)
        elderPhoneNumberUpperLabel.leading(equalTo: elderNameUpperLabel.leadingAnchor, constant: 0)
        elderPhoneNumberLabel.layout.top(equalTo: elderPhoneNumberUpperLabel.bottomAnchor, constant: 10)
        elderPhoneNumberLabel.leading(equalTo: elderNameUpperLabel.leadingAnchor, constant: 0)
        logOutButton.layout.top(equalTo: elderInfoFieldView.bottomAnchor, constant: 20)
        logOutButton.leading(constant: 20)
        logOutButton.bottom(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        logOutButton.trailing(constant: -20)
    }
    
    @objc func didTapLogoutButton(_ sender: UIButton) {
        let vc = HelperSelectSignInAndSignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
