//
//  HelperSignUpViewController.swift
//  SaveElderProject
//
//  Created by Demian on 2020/01/15.
//  Copyright © 2020 Demian. All rights reserved.
//

import UIKit
import Firebase


//Helper Sign Up first VC
class HelperSignUpViewController: UIViewController {
    
        //MARK: 변수 선언
    var welcomeLabel = UILabel()
    var emailTextField = UITextField()
    var emailLabel = UILabel()
    var emailCheckLabel = UILabel()
    var emailCheckButton = UIButton(type: .system)
    var passwordTextField = UITextField()
    var passwordCheckLabel = UILabel()
    var nameTextField = UITextField()
    var nameCheckLabel = UILabel()
    var phoneNumberTextField = UITextField()
    var phoneNumberLabel = UILabel()
    var signUpButton = UIButton(type: .system)
    var resignKeyboard = UIView()
    let failViewID = UIView()
    let failViewPW = UIView()
    let failViewName = UIView()
    let failViewPhone = UIView()
    var centerOriginX = CGFloat()
    let activitiyIndicator = UIActivityIndicatorView()
    
    //MARK: ViewdidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
        let gesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(gesture)
    }
    //MARK: viewSafeAreaInsetsDidChange
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setupUI()
        dismissButtonSetUp()
    }
    
    //MARK: dismissButtonSetup
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
    
    //MARK: SetupUI
    //SetUpUI func - private
    private func setupUI() {
        welcomeLabel.text = "보호자 정보 입력"
        welcomeLabel.font = UIFont(name: "Arial", size: 22)
        welcomeLabel.textColor = .black
        welcomeLabel.textAlignment = .center
        view.addSubview(welcomeLabel)
        emailTextField.layer.borderColor = UIColor.gray.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 4
        emailTextField.placeholder = " 이메일을 입력해주세요."
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTextField.frame.height))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = .always
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        view.addSubview(emailTextField)
        emailCheckLabel.text = "예) sky@naver.com"
        emailCheckLabel.font = UIFont(name: "Arial", size: 13)
        view.addSubview(emailCheckLabel)
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.placeholder = " 비밀번호를 입력해주세요."
        
        let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordTextField.leftView = paddingView2
        passwordTextField.leftViewMode = .always
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        passwordCheckLabel.text = "6자리 이상의 비밀번호를 설정해주세요."
        passwordCheckLabel.font = UIFont(name: "Arial", size: 13)
        view.addSubview(passwordCheckLabel)
        //
        //        emailLabel.text = "이메일을 입력해주세요"
        //        emailLabel.font = UIFont(name: "Arial", size: 15)
        //        emailLabel.textColor = .black
        nameTextField.placeholder = " 이름을 입력해주세요."
        nameTextField.layer.borderColor = UIColor.gray.cgColor
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.cornerRadius = 4
        
        let paddingView3 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTextField.frame.height))
        nameTextField.leftView = paddingView3
        nameTextField.leftViewMode = .always
        nameTextField.autocorrectionType = .no
        nameTextField.autocapitalizationType = .none
        view.addSubview(nameTextField)
        nameCheckLabel.text = "예) 홍길동"
        nameCheckLabel.font = UIFont(name: "Arial", size: 13)
        view.addSubview(nameCheckLabel)
     
        phoneNumberTextField.layer.borderColor = UIColor.gray.cgColor
        phoneNumberTextField.layer.borderWidth = 1
        phoneNumberTextField.layer.cornerRadius = 4
        phoneNumberTextField.placeholder = " 전화번호를 입력해주세요"
        
        let paddingView4 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: phoneNumberTextField.frame.height))
        phoneNumberTextField.leftView = paddingView4
        phoneNumberTextField.leftViewMode = .always
        phoneNumberTextField.keyboardType = UIKeyboardType.numberPad
        view.addSubview(phoneNumberTextField)
        
        phoneNumberLabel.text = "- 를 제외하고 입력해주세요. 예) 01012345678"
        phoneNumberLabel.font = UIFont(name: "Arial", size: 13)
        view.addSubview(phoneNumberLabel)
        
        signUpButton.setTitle("다음", for: .normal)
        signUpButton.titleLabel?.textAlignment = .center
        signUpButton.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = UIColor(named: "mypink")
        signUpButton.shadow()
        signUpButton.layer.cornerRadius = 4
        signUpButton.addTarget(self, action: #selector(signupEvent), for: .touchUpInside)
        view.addSubview(signUpButton)
        view.addSubview(activitiyIndicator)
        setupConstraints()
        
        failViewSetUp()
    }
    
    
    //MARK: SetupConstraints
    private func setupConstraints() {
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailCheckLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordCheckLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameCheckLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        activitiyIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            welcomeLabel.widthAnchor.constraint(equalToConstant: 200),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.topAnchor.constraint(equalTo: welcomeLabel.topAnchor, constant: 100),
            emailTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 320),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailCheckLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 5),
            emailCheckLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: 3),
            passwordTextField.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor, constant: 100),
            passwordTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 320),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordCheckLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5),
            passwordCheckLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 3),
            nameTextField.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor, constant: 100),
            nameTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 320),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameCheckLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 5),
            nameCheckLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: 3),
            phoneNumberTextField.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor, constant: 100),
            phoneNumberTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            phoneNumberTextField.widthAnchor.constraint(equalToConstant: 320),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            phoneNumberLabel.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 5),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: phoneNumberTextField.leadingAnchor, constant: 3),
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            signUpButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 320),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            activitiyIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activitiyIndicator.centerYAnchor.constraint(equalTo: phoneNumberTextField.centerYAnchor, constant: 80),
            activitiyIndicator.widthAnchor.constraint(equalToConstant: 30),
            activitiyIndicator.heightAnchor.constraint(equalToConstant: 30),
        ])
        activitiyIndicator.style = .large
        activitiyIndicator.isHidden = true
    }
    
    //SignUpEvent Objc func
    //MARK: SignUpEvent
    @objc private func signupEvent() {
        UIView.animate(withDuration: 2.0) {
            self.activitiyIndicator.isHidden = false
            self.activitiyIndicator.startAnimating()
        }
        if emailTextField.text?.contains("@") == true && emailTextField.text?.contains(".") == true && passwordTextField.text?.count ?? 0 >= 6 {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, err) in
                if err == nil {
                    let uid = user?.user.uid //현재 회원의 uid
                    let values = ["userName": self.nameTextField.text ?? "noname",
                                  "phoneNumber": self.phoneNumberTextField.text ?? "wrongNumber",
                                  "uid":Auth.auth().currentUser?.uid
                        ] as [String : Any]
                    Database.database().reference().child("users").child(uid!).setValue(values) { (err, ref) in
                        if err == nil && self.nameTextField.text?.count ?? 0 >= 2 && self.phoneNumberTextField.text?.count ?? 0 == 11 {
                            let helperSignUpSecondVC = HelperSignUpSecondViewController()
                            helperSignUpSecondVC.modalPresentationStyle = .fullScreen
                            self.present(helperSignUpSecondVC, animated: true)
                            print("회원가입이 완료되었습니다.")
                        } else {
                            print("회원가입 실패")
                            self.activitiyIndicator.isHidden = true
                            self.activitiyIndicator.stopAnimating()
                            self.failEvent()
                        }
                    }
                }
            }
        } else {
            print("wrong Info")
            self.activitiyIndicator.isHidden = true
            self.activitiyIndicator.stopAnimating()
            failEvent()
        }
    }
    
    //MARK: 로그인 실패View Setup
    private func failViewSetUp() {
        view.addSubview(failViewID)
        failViewID.layer.borderColor = UIColor.red.cgColor
        failViewID.layer.cornerRadius = 4
        failViewID.layer.borderWidth = 3
        failViewID.alpha = 0.0
        failViewID.layout.centerX(equalTo: emailTextField.centerXAnchor).centerY(equalTo: emailTextField.centerYAnchor)
        failViewID.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
        failViewID.heightAnchor.constraint(equalTo: emailTextField.heightAnchor).isActive = true
        
        view.addSubview(failViewPW)
        failViewPW.layer.borderColor = UIColor.red.cgColor
        failViewPW.layer.cornerRadius = 4
        failViewPW.layer.borderWidth = 3
        failViewPW.alpha = 0.0
        failViewPW.layout.centerX(equalTo: passwordTextField.centerXAnchor).centerY(equalTo: passwordTextField.centerYAnchor)
        failViewPW.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor).isActive = true
        failViewPW.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor).isActive = true
        
        view.addSubview(failViewName)
        failViewName.layer.borderColor = UIColor.red.cgColor
        failViewName.layer.cornerRadius = 4
        failViewName.layer.borderWidth = 3
        failViewName.alpha = 0.0
        failViewName.layout.centerX(equalTo: nameTextField.centerXAnchor).centerY(equalTo: nameTextField.centerYAnchor)
        failViewName.widthAnchor.constraint(equalTo: nameTextField.widthAnchor).isActive = true
        failViewName.heightAnchor.constraint(equalTo: nameTextField.heightAnchor).isActive = true
        
        view.addSubview(failViewPhone)
        failViewPhone.layer.borderColor = UIColor.red.cgColor
        failViewPhone.layer.cornerRadius = 4
        failViewPhone.layer.borderWidth = 3
        failViewPhone.alpha = 0.0
        failViewPhone.layout.centerX(equalTo: phoneNumberTextField.centerXAnchor).centerY(equalTo: phoneNumberTextField.centerYAnchor)
        failViewPhone.widthAnchor.constraint(equalTo: phoneNumberTextField.widthAnchor).isActive = true
        failViewPhone.heightAnchor.constraint(equalTo: phoneNumberTextField.heightAnchor).isActive = true
    }
    
    //MARK: FailEvent
    private func failEvent() { // 로그인 실패시 이벤트
        centerOriginX = self.emailTextField.center.x
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                self.failViewID.alpha = 1.5
                self.failViewPW.alpha = 1.5
                self.failViewName.alpha = 1.5
                self.failViewPhone.alpha = 1.5
                
                self.emailTextField.center.x -= 25
                self.failViewID.center.x -= 25
                
                self.passwordTextField.center.x -= 25
                self.failViewPW.center.x -= 25
                
                self.nameTextField.center.x -= 25
                self.failViewName.center.x -= 25
                
                self.phoneNumberTextField.center.x -= 25
                self.failViewPhone.center.x -= 25
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                self.emailTextField.center.x += 35
                self.failViewID.center.x += 35
                
                self.passwordTextField.center.x += 35
                self.failViewPW.center.x += 35
                
                self.nameTextField.center.x += 35
                self.failViewName.center.x += 35
                
                self.phoneNumberTextField.center.x += 35
                self.failViewPhone.center.x += 35
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2) {
                self.emailTextField.center.x -= 25
                self.failViewID.center.x -= 25
                
                self.passwordTextField.center.x -= 25
                self.failViewPW.center.x -= 25
                
                self.nameTextField.center.x -= 25
                self.failViewName.center.x -= 25
                
                self.phoneNumberTextField.center.x -= 25
                self.failViewPhone.center.x -= 25
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self.emailTextField.center.x += 35
                self.failViewID.center.x += 35
                
                self.passwordTextField.center.x += 35
                self.failViewPW.center.x += 35
                
                self.nameTextField.center.x += 35
                self.failViewName.center.x += 35
                
                self.phoneNumberTextField.center.x += 35
                self.failViewPhone.center.x += 35
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                self.emailTextField.center.x -= 25
                self.failViewID.center.x -= 25
                
                self.passwordTextField.center.x -= 25
                self.failViewPW.center.x -= 25
                
                self.nameTextField.center.x -= 25
                self.failViewName.center.x -= 25
                
                self.phoneNumberTextField.center.x -= 25
                self.failViewPhone.center.x -= 25
            }
            UIView.addKeyframe(withRelativeStartTime: 0.95, relativeDuration: 0.2) {
                self.emailTextField.center.x += 35
                self.failViewID.center.x += 35
                self.emailTextField.center.x = self.centerOriginX
                self.failViewID.center.x = self.centerOriginX
                
                self.passwordTextField.center.x += 35
                self.failViewPW.center.x += 35
                self.passwordTextField.center.x = self.centerOriginX
                self.failViewPW.center.x = self.centerOriginX
                
                self.nameTextField.center.x += 35
                self.failViewName.center.x += 35
                self.nameTextField.center.x = self.centerOriginX
                self.failViewName.center.x = self.centerOriginX
                
                self.phoneNumberTextField.center.x += 35
                self.failViewPhone.center.x += 35
                self.phoneNumberTextField.center.x = self.centerOriginX
                self.failViewPhone.center.x = self.centerOriginX
                
                self.failViewID.alpha = 0.0
                self.failViewPW.alpha = 0.0
                self.failViewName.alpha = 0.0
                self.failViewPhone.alpha = 0.0
            }
        })
    }
    
}

//MARK: Extension: UITextFieldDelegate
extension HelperSignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            nameTextField.becomeFirstResponder()
        } else if textField == nameTextField {
            phoneNumberTextField.becomeFirstResponder()
        } else {
            phoneNumberTextField.resignFirstResponder()
            UIView.animate(withDuration: 0.3, animations: ({
                self.emailTextField.transform = .identity
                self.emailCheckLabel.transform = .identity
                self.passwordTextField.transform = .identity
                self.passwordCheckLabel.transform = .identity
                self.nameTextField.transform = .identity
                self.nameCheckLabel.transform = .identity
                self.phoneNumberTextField.transform = .identity
                self.phoneNumberLabel.transform = .identity
                
                self.welcomeLabel.isHidden = false
            }))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.signupEvent()
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == nameTextField || textField == phoneNumberTextField {
            UIView.animate(withDuration: 0.3, animations: ({
                self.emailTextField.transform = CGAffineTransform(translationX: 0, y: -50)
                self.emailCheckLabel.transform = CGAffineTransform(translationX: 0, y: -50)
                self.passwordTextField.transform = CGAffineTransform(translationX: 0, y: -50)
                self.passwordCheckLabel.transform = CGAffineTransform(translationX: 0, y: -50)
                self.nameTextField.transform = CGAffineTransform(translationX: 0, y: -50)
                self.nameCheckLabel.transform = CGAffineTransform(translationX: 0, y: -50)
                self.phoneNumberTextField.transform = CGAffineTransform(translationX: 0, y: -50)
                self.phoneNumberLabel.transform = CGAffineTransform(translationX: 0, y: -50)
                
                self.welcomeLabel.isHidden = true
            }))
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: ({
            self.emailTextField.transform = .identity
            self.emailCheckLabel.transform = .identity
            self.passwordTextField.transform = .identity
            self.passwordCheckLabel.transform = .identity
            self.nameTextField.transform = .identity
            self.nameCheckLabel.transform = .identity
            self.phoneNumberTextField.transform = .identity
            self.phoneNumberLabel.transform = .identity
            self.welcomeLabel.isHidden = false
        }))
    }
    
}

