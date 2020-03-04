//
//  HelperSignInViewController.swift
//  SaveElderProject
//
//  Created by Demian on 2020/01/15.
//  Copyright © 2020 Demian. All rights reserved.
//

import UIKit
import Firebase

class HelperSignInViewController: UIViewController {
    
    //MARK: 변수 선언
    let logInLabel = UILabel()
    let idTextField = UITextField()
    let pwTextField = UITextField()
    let signInButton = UIButton()
    let backButton = UIButton()
    let alarmLabel = UILabel()
    let activitiyIndicator = UIActivityIndicatorView()
    let failViewID = UIView()
    let failViewPW = UIView()
    
    var userName = ""
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let gesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(gesture)
        idTextField.delegate = self
        pwTextField.delegate = self
    }
    
    
    //MARK: ViewSafeAreaInsetsDidChange
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
    
    
    //MARK: UI setup
    func setupUI(){
        let standardView = view.safeAreaLayoutGuide
        let views = [logInLabel, idTextField, pwTextField, signInButton, backButton, alarmLabel, activitiyIndicator]
        for uiView in views {
            view.addSubview(uiView)
            uiView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //로그인 레이블 위치
        NSLayoutConstraint.activate([
            logInLabel.topAnchor.constraint(equalTo: standardView.topAnchor, constant: 90),
            logInLabel.centerXAnchor.constraint(equalTo: standardView.centerXAnchor),
            logInLabel.widthAnchor.constraint(equalTo: standardView.widthAnchor, multiplier: 0.7),
        ])
        logInLabel.textAlignment = .center
        logInLabel.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        logInLabel.font = .systemFont(ofSize: 40, weight: .bold)
        logInLabel.text = "안녕하세요!"
        logInLabel.alpha = 0.0
        
        UIView.animate(withDuration: 1.5) {
            self.logInLabel.center.x -= 50
            self.logInLabel.alpha = 1
        }
        
        //이메일입력 위치
        NSLayoutConstraint.activate([
            idTextField.topAnchor.constraint(equalTo: standardView.topAnchor, constant: 170),
            idTextField.centerXAnchor.constraint(equalTo: logInLabel.centerXAnchor),
            idTextField.widthAnchor.constraint(equalToConstant: 320),
            idTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        idTextField.font = .systemFont(ofSize: 17)
        idTextField.placeholder = "이메일을 입력하세요"
        idTextField.layer.borderWidth = 1
        idTextField.layer.borderColor = UIColor.gray.cgColor
        idTextField.layer.cornerRadius = 4
        idTextField.autocapitalizationType = .none
        idTextField.autocorrectionType = .yes
        idTextField.keyboardType = .emailAddress
        let idPaddinView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: idTextField.frame.height))
        idTextField.leftView = idPaddinView
        idTextField.leftViewMode = .always
        
        //패스워드입력 위치
        NSLayoutConstraint.activate([
            pwTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 25),
            pwTextField.centerXAnchor.constraint(equalTo: idTextField.centerXAnchor),
            pwTextField.widthAnchor.constraint(equalToConstant: 320),
            pwTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        pwTextField.font = .systemFont(ofSize: 17)
        pwTextField.placeholder = "패스워드를 입력하세요"
        pwTextField.layer.borderWidth = 1
        pwTextField.layer.borderColor = UIColor.gray.cgColor
        pwTextField.layer.cornerRadius = 4
        pwTextField.enablesReturnKeyAutomatically = true
        pwTextField.autocorrectionType = .no
        pwTextField.isSecureTextEntry = true
        pwTextField.autocapitalizationType = .none
        let pwPaddinView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: idTextField.frame.height))
        pwTextField.leftView = pwPaddinView
        pwTextField.leftViewMode = .always
        
        
        //로그인버튼
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: 130),
            signInButton.centerXAnchor.constraint(equalTo: pwTextField.centerXAnchor),
            signInButton.widthAnchor.constraint(equalToConstant: 320),
            signInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        signInButton.backgroundColor = UIColor(named: "mypink")
        signInButton.setTitle("시작하기", for: .normal)
        signInButton.layer.cornerRadius = 4
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.titleLabel?.textAlignment = .center
        signInButton.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        signInButton.shadow()
        signInButton.addTarget(self, action: #selector(elderLogInEvent(_:)), for: .touchUpInside)
        
        //알람 레이블
        NSLayoutConstraint.activate([
            alarmLabel.topAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: 50),
            alarmLabel.widthAnchor.constraint(equalToConstant: 350),
            alarmLabel.centerXAnchor.constraint(equalTo: pwTextField.centerXAnchor)
        ])
        alarmLabel.text = "이메일 혹은 비밀번호를 확인해주세요"
        alarmLabel.textAlignment = .center
        alarmLabel.font = .systemFont(ofSize: 20, weight: .bold)
        alarmLabel.textColor = .black
        alarmLabel.alpha = 0.0
        
        //인디케이터
        NSLayoutConstraint.activate([
            activitiyIndicator.centerXAnchor.constraint(equalTo: alarmLabel.centerXAnchor),
            activitiyIndicator.centerYAnchor.constraint(equalTo: alarmLabel.centerYAnchor),
            activitiyIndicator.widthAnchor.constraint(equalToConstant: 10),
            activitiyIndicator.heightAnchor.constraint(equalToConstant: 10)
        ])
        activitiyIndicator.isHidden = true
        
        
        failViewSetUp()
        
    }
    
    
    //MARK: 로그인기능
    @objc private func elderLogInEvent(_ sender: UIButton) {
        UIView.animate(withDuration: 2) {
            self.activitiyIndicator.isHidden = false
            self.activitiyIndicator.startAnimating()
        }
        let helperMain = HelperMainViewController()
        if idTextField.text?.contains("@") == true && idTextField.text?.contains(".") == true && pwTextField.text?.count ?? 0 >= 6 { //정규 표현식을 사용하자 !
            
            Auth.auth().signIn(withEmail: idTextField.text!, password: pwTextField.text!) { (user, error) in
                if user != nil {
                    print("success")
                    helperMain.modalPresentationStyle = .fullScreen
                    self.present(helperMain, animated: true)
                } else { // 로그인 실패
                    self.activitiyIndicator.isHidden = true
                    self.activitiyIndicator.stopAnimating()
                    self.failEvent()
                    print("로그인 실패")
                }
            }
        } else { //입력값 오류
            self.activitiyIndicator.isHidden = true
            self.activitiyIndicator.stopAnimating()
            self.failEvent()
            print("입력값 오류")
        }
    }
    
    
    //MARK: 로그인 실패 View Setup
    private func failViewSetUp() {
        view.addSubview(failViewID)
        failViewID.layer.borderColor = UIColor.red.cgColor
        failViewID.layer.cornerRadius = 4
        failViewID.layer.borderWidth = 3
        failViewID.alpha = 0.0
        failViewID.layout.centerX(equalTo: idTextField.centerXAnchor).centerY(equalTo: idTextField.centerYAnchor)
        failViewID.widthAnchor.constraint(equalTo: idTextField.widthAnchor).isActive = true
        failViewID.heightAnchor.constraint(equalTo: idTextField.heightAnchor).isActive = true
        
        view.addSubview(failViewPW)
        failViewPW.layer.borderColor = UIColor.red.cgColor
        failViewPW.layer.cornerRadius = 4
        failViewPW.layer.borderWidth = 3
        failViewPW.alpha = 0.0
        failViewPW.layout.centerX(equalTo: pwTextField.centerXAnchor).centerY(equalTo: pwTextField.centerYAnchor)
        failViewPW.widthAnchor.constraint(equalTo: pwTextField.widthAnchor).isActive = true
        failViewPW.heightAnchor.constraint(equalTo: pwTextField.heightAnchor).isActive = true
    }
    
    
    //MARK: FailEvent
    private func failEvent() { // 로그인 실패시 이벤트
        let centerOrigin = self.idTextField.center.x
        UIView.animate(withDuration: 1.5) {
            self.alarmLabel.alpha = 1.0
            self.alarmLabel.alpha = 0.0
        }
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                self.failViewID.alpha = 1.5
                self.failViewPW.alpha = 1.5
                
                self.idTextField.center.x -= 25
                self.failViewID.center.x -= 25
                
                self.pwTextField.center.x -= 25
                self.failViewPW.center.x -= 25
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                self.idTextField.center.x += 35
                self.failViewID.center.x += 35
                
                self.pwTextField.center.x += 35
                self.failViewPW.center.x += 35
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2) {
                self.idTextField.center.x -= 25
                self.failViewID.center.x -= 25
                
                self.pwTextField.center.x -= 25
                self.failViewPW.center.x -= 25
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self.idTextField.center.x += 35
                self.failViewID.center.x += 35
                
                self.pwTextField.center.x += 35
                self.failViewPW.center.x += 35
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                self.idTextField.center.x -= 25
                self.failViewID.center.x -= 25
                
                self.pwTextField.center.x -= 25
                self.failViewPW.center.x -= 25
            }
            UIView.addKeyframe(withRelativeStartTime: 0.95, relativeDuration: 0.2) {
                self.idTextField.center.x += 35
                self.idTextField.center.x = centerOrigin
                self.failViewID.center.x += 35
                self.failViewID.center.x = centerOrigin
                
                
                self.pwTextField.center.x += 35
                self.pwTextField.center.x = centerOrigin
                self.failViewPW.center.x += 35
                self.failViewPW.center.x = centerOrigin
                self.failViewID.alpha = 0.0
                self.failViewPW.alpha = 0.0
            }
        })
    }
}


//MARK: UITextFieldDelegate
extension HelperSignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == idTextField {
            pwTextField.becomeFirstResponder()
        } else {
            pwTextField.resignFirstResponder()
            elderLogInEvent(signInButton)
        }
        return true
    }
}
