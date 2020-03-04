//
//  HelperSelectSignInAndSignUpViewController.swift
//  SaveElderProject
//
//  Created by Demian on 2020/01/15.
//  Copyright © 2020 Demian. All rights reserved.
//

import UIKit

class HelperSelectSignInAndSignUpViewController: UIViewController {
    
        //MARK: 변수 선언
    let logInView = UIView()
    let signInView = UIView()
    var logInBtn = UIButton()
    var signInBtn = UIButton()
    var logInLabel = UILabel()
    var signInLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setupUI()
    }
    
    //MARK: SetupUI
    private func setupUI() {
        logInView.shadow()
        logInView.backgroundColor = .white
        signInView.shadow()
        signInView.backgroundColor = .white
        logInBtn = self.btnStyle(title: "로그인")
        logInBtn.backgroundColor = UIColor(named: "mypink")
        logInBtn.addTarget(self, action: #selector(logInBtnAction), for: .touchUpInside)
        signInBtn = self.btnStyle(title: "회원가입")
        signInBtn.backgroundColor = UIColor(named: "mypink")
        signInBtn.addTarget(self, action: #selector(signInBtnAction), for: .touchUpInside)
        logInLabel = self.labelStyle()
        logInLabel.text = "기존 회원이라면 \n로그인을 해주세요"
        signInLabel = self.labelStyle()
        signInLabel.text = "가입 한 적이 없다면 \n회원가입을 해주세요"
        [signInView, logInView, logInBtn, signInBtn, logInLabel, signInLabel].forEach {
            view.addSubview($0)
        }
        setupConstraint()
    }
    
        //MARK: Set up Constraints
    private func setupConstraint() {
        let guide = self.view.safeAreaLayoutGuide
        logInView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logInView.topAnchor.constraint(equalTo: guide.topAnchor,constant: 0),
            logInView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0),
            logInView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 0),
            logInView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.5)
        ])
        signInView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInView.topAnchor.constraint(equalTo: logInView.bottomAnchor,constant: 0),
            signInView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0),
            signInView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 0),
            signInView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.5)
        ])
        logInBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logInBtn.bottomAnchor.constraint(equalTo: logInView.bottomAnchor, constant: -32),
            logInBtn.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            logInBtn.widthAnchor.constraint(equalToConstant: 320),
            logInBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        signInBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInBtn.bottomAnchor.constraint(equalTo: signInView.bottomAnchor, constant: -32),
            signInBtn.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            signInBtn.widthAnchor.constraint(equalToConstant: 320),
            signInBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        logInLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logInLabel.centerYAnchor.constraint(equalTo: logInView.centerYAnchor, constant: -20),
            logInLabel.centerXAnchor.constraint(equalTo: logInView.centerXAnchor, constant: 0)
        ])
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInLabel.centerYAnchor.constraint(equalTo: signInView.centerYAnchor, constant: -20),
            signInLabel.centerXAnchor.constraint(equalTo: signInView.centerXAnchor, constant: 0)
        ])
    }
    
        //MARK: Button & Label Style settings
    private func btnStyle(title: String) -> UIButton { // 버튼 스타일 함수
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        button.shadow()
        return button
    }
    
    private func labelStyle() -> UILabel { // 라벨 스타일 함수
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 26, weight: .regular)
        label.textAlignment = .center
        return label
    }
    
    
        //MARK: Login Action
    @objc private func logInBtnAction(_ sender: UIButton) {
        let HelperSignInVC = HelperSignInViewController()
        HelperSignInVC.modalPresentationStyle = .fullScreen
        present(HelperSignInVC, animated: true)
    }
    
        //MARK: Sign In Button Action
    @objc private func signInBtnAction(_ sneder:UIButton) {
        let initialVC = InitialViewController()
        initialVC.modalPresentationStyle = .fullScreen
        present(initialVC, animated: true)
    }
}
