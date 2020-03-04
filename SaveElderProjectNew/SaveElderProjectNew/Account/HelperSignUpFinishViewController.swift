//
//  HelperSignUpFinishViewController.swift
//  SaveElderProject
//
//  Created by Demian on 2020/01/15.
//  Copyright © 2020 Demian. All rights reserved.
//

import UIKit
import Firebase


//MARK: Helper invite code Sending VC

class HelperSignUpFinishViewController: UIViewController {
    
        //MARK: 변수 선언
    let elderCodetitleLabel = UILabel()
    let elderCodeLabel = UILabel()
    let appGuideLabel = UILabel()
    var elderSendMessageBtn = UIButton()
    var startBtn = UIButton()
    let startLabel = UILabel()
    let activitiyIndicator = UIActivityIndicatorView()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    //MARK: ViewSafeAreaInsetsDidChange
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setupUI()
    }

    
    //MARK: SetupUI
    private func setupUI() {
        
        elderCodetitleLabel.text = "피보호자 초대 코드"
        guard let elderCode = UserDefaults.standard.string(forKey: "elderCode") else { return }
        elderCodeLabel.text = elderCode
        elderCodeLabel.font = .systemFont(ofSize: 32)
        appGuideLabel.numberOfLines = 0
        appGuideLabel.text = "1.\n피보호자 핸드폰에 메세지를 보내 \n앱을 깔고 피보호자 초대코드로 \n회원가입을 하세요"
        appGuideLabel.font = .systemFont(ofSize: 18)
        elderSendMessageBtn = self.btnStyle(title: "피보호자에게 메세지 보내기")
        elderSendMessageBtn.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        elderSendMessageBtn.addTarget(self, action: #selector(sendMessageAction), for: .touchUpInside)
        startLabel.numberOfLines = 0
        startLabel.text = "2.\n피보호자 핸드폰에 모든 셋팅이\n끝나셨나요?"
        startLabel.font = .systemFont(ofSize: 18)
        startBtn = self.btnStyle(title: "시작하기")
        startBtn.backgroundColor = UIColor(named: "mypink")
        startBtn.addTarget(self, action: #selector(startAction), for: .touchUpInside)
        [elderCodetitleLabel, elderCodeLabel, appGuideLabel, elderSendMessageBtn, startBtn, startLabel].forEach {
            view.addSubview($0)
        }
        
        view.addSubview(activitiyIndicator)
        setupConstraint()
    }
    
    //MARK: Setup Constraints
    private func setupConstraint() {
        let guide = self.view.safeAreaLayoutGuide
        elderCodetitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            elderCodetitleLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 80),
            elderCodetitleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 40)
        ])
        elderCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            elderCodeLabel.topAnchor.constraint(equalTo: elderCodetitleLabel.bottomAnchor, constant: 20),
            elderCodeLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 40)
        ])
        appGuideLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appGuideLabel.topAnchor.constraint(equalTo: elderCodeLabel.bottomAnchor, constant: 40),
            appGuideLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 40)
        ])
        elderSendMessageBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            elderSendMessageBtn.topAnchor.constraint(equalTo: appGuideLabel.bottomAnchor, constant: 40),
            elderSendMessageBtn.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 40),
            elderSendMessageBtn.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -40),
            elderSendMessageBtn.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.08)
            ])
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startLabel.topAnchor.constraint(equalTo: elderSendMessageBtn.bottomAnchor, constant: 100),
            startLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 40)
        ])
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        activitiyIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startBtn.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 40),
            startBtn.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 40),
            startBtn.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -40),
            startBtn.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.08),
            activitiyIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                activitiyIndicator.centerYAnchor.constraint(equalTo: elderSendMessageBtn.bottomAnchor, constant: 50),
                activitiyIndicator.widthAnchor.constraint(equalToConstant: 30),
                activitiyIndicator.heightAnchor.constraint(equalToConstant: 30),
            ])
            activitiyIndicator.isHidden = true
            activitiyIndicator.style = .large
        
    }
    
    //MARK: ButtonStyle
    private func btnStyle(title: String) -> UIButton { // 버튼 스타일 함수
        
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        button.shadow()
        
        return button
    }
    
    //MARK: SendMessageAction
    @objc private func sendMessageAction() {
        
        let ref = Database.database().reference()
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        ref.child("users").child(uid).child("ElderInfo").observeSingleEvent(of: .value) { snapshop in
            guard let elderPhoneNumber = snapshop.value as? [String:Any] else { return }
            let elderNum = elderPhoneNumber["ElderPhoneNumber"] as? String ?? "fail"
            print("elderNum: \(elderNum)")
            guard let elderCode = UserDefaults.standard.string(forKey: "elderCode") else { return }
            print("\n---------- [ openMessage ] ----------\n")
            let url = URL(string: "sms:\(elderNum)&body=\(elderCode)")!
            print(url)
            guard UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url)
        }
    }
    
    //MARK: StartAction
    @objc private func startAction() {
        
        UIView.animate(withDuration: 2.0) {
            self.activitiyIndicator.isHidden = false
            self.activitiyIndicator.startAnimating()
        }
        
        let helperMainVC = HelperMainViewController()
        helperMainVC.modalPresentationStyle = .fullScreen
        present(helperMainVC, animated: true)
    }
}
