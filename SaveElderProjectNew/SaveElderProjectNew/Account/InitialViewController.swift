//
//  InitialViewController.swift
//  SaveElderProject
//
//  Created by Demian on 2020/01/15.
//  Copyright © 2020 Demian. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
        //MARK: 변수 선언
    let helperView = UIView()
    let elderView = UIView()
    var helperBtn = UIButton()
    var elderBtn = UIButton()
    let helperImg = UIImageView()
    let elderImg = UIImageView()
    var helperLabel = UILabel()
    var elderLabel = UILabel()
    
        //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    
    //MARK: viewSafeAreaInsetsDidChange
   override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setupUI()
        dismissButtonSetUp()
    }
    
    //MARK: DismissButton Setup
    private func dismissButtonSetUp() {
        let dismissButton = UIButton()
        view.addSubview(dismissButton)
        
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dismissButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,  constant: 10),
            dismissButton.widthAnchor.constraint(equalToConstant: 50),
            dismissButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        dismissButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        dismissButton.tintColor = .black
        dismissButton.setPreferredSymbolConfiguration(.init(pointSize: 30), forImageIn: .normal)
        dismissButton.addTarget(self, action: #selector(didTapDismiss(_:)), for: .touchUpInside)
        
    }
    
    @objc private func didTapDismiss(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    //MARK: Setup UI
    private func setupUI() {
        helperView.shadow()
        helperView.backgroundColor = .white
        elderView.shadow()
        elderView.backgroundColor = .white
        helperBtn = self.btnStyle(title: "보호자 회원가입")
        helperBtn.backgroundColor = UIColor(named: "mypink")
        helperBtn.addTarget(self, action: #selector(helperBtnAction), for: .touchUpInside)
        elderBtn = self.btnStyle(title: "피보호자 회원가입")
        elderBtn.backgroundColor = UIColor(named: "mypink")
        elderBtn.addTarget(self, action: #selector(elderBtnAction(_:)), for: .touchUpInside)
//        helperImg.backgroundColor = .lightGray
        helperImg.image = UIImage(named: "helper")
        helperLabel = self.labelStyle()
        helperLabel.text = "항상 같은 공간에 있지 않아도 \n피보호자의 정보를 확인 하세요"
        elderImg.image = UIImage(named: "elder")
        elderLabel = self.labelStyle()
        elderLabel.text = "보호자에게 위치를 전송해서 \n혹시 모를 상황을 대비하세요"
        [helperView, helperBtn, elderView, elderBtn, helperImg, helperLabel, elderImg, elderLabel].forEach {
            view.addSubview($0)
        }
        setupConstraint()
    }
    
    //MARK: SetupConstraints
    private func setupConstraint() {
        let guide = self.view.safeAreaLayoutGuide
        helperView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            helperView.topAnchor.constraint(equalTo: guide.topAnchor,constant: 0),
            helperView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0),
            helperView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 0),
            helperView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.5)
        ])
        elderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            elderView.topAnchor.constraint(equalTo: helperView.bottomAnchor,constant: 0),
            elderView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0),
            elderView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 0),
            elderView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.5)
        ])
        helperBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            helperBtn.bottomAnchor.constraint(equalTo: helperView.bottomAnchor, constant: -32),
            helperBtn.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            helperBtn.widthAnchor.constraint(equalToConstant: 320),
            helperBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        elderBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            elderBtn.bottomAnchor.constraint(equalTo: elderView.bottomAnchor, constant: -32),
            elderBtn.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            elderBtn.widthAnchor.constraint(equalToConstant: 320),
            elderBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        helperImg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            helperImg.topAnchor.constraint(equalTo: helperView.topAnchor, constant: 40),
            helperImg.centerXAnchor.constraint(equalTo: helperView.centerXAnchor),
            helperImg.heightAnchor.constraint(equalTo: helperView.heightAnchor, multiplier: 0.4),
            helperImg.widthAnchor.constraint(equalTo: helperView.widthAnchor, multiplier: 0.4)
        ])
        helperLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            helperLabel.topAnchor.constraint(equalTo: helperImg.bottomAnchor, constant: 24),
            helperLabel.centerXAnchor.constraint(equalTo: helperView.centerXAnchor, constant: 0)
        ])
        elderImg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            elderImg.topAnchor.constraint(equalTo: elderView.topAnchor, constant: 40),
            elderImg.centerXAnchor.constraint(equalTo: elderView.centerXAnchor),
            elderImg.heightAnchor.constraint(equalTo: elderView.heightAnchor, multiplier: 0.4),
            elderImg.widthAnchor.constraint(equalTo: elderView.widthAnchor, multiplier: 0.4)
        ])
        elderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            elderLabel.topAnchor.constraint(equalTo: elderImg.bottomAnchor, constant: 24),
            elderLabel.centerXAnchor.constraint(equalTo: elderView.centerXAnchor, constant: 0)
        ])
    }
    
    //MARK: ButtonStyle Settings
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
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }
    
    
    //MARK: HelperButtonAction
    @objc private func helperBtnAction(_ sender: UIButton) {
        let helperSignUpVC = HelperSignUpViewController()
        helperSignUpVC.modalPresentationStyle = .fullScreen
        present(helperSignUpVC, animated: true)
    }
    //MARK: ElderButton Action
    @objc private func elderBtnAction(_ sneder:UIButton) {
       let elderSignUpVC = ElderSignUpViewController()
        elderSignUpVC.modalPresentationStyle = .fullScreen
        present(elderSignUpVC, animated: true)
    }
}
