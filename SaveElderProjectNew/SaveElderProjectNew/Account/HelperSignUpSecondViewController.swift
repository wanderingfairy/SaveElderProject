//
//  HelperSignUpSecondViewController.swift
//  SaveElderProject
//
//  Created by Demian on 2020/01/15.
//  Copyright © 2020 Demian. All rights reserved.
//

import UIKit
import Firebase

//Helper Sign Up Second ViewController
class HelperSignUpSecondViewController: UIViewController {
    
        //MARK: 변수 선언
    var welcomeLabel = UILabel()
    var nameTextField = UITextField()
    var nameLabel = UILabel()
    var nameCheckLabel = UILabel()
    var nameCheckButton = UIButton(type: .system)
    var phoneNumberTextField = UITextField()
    var phoneNumberCheckLabel = UILabel()
    var signUpButton = UIButton(type: .system)
    let failViewName = UIView()
    let failViewPhone = UIView()
    let activitiyIndicator = UIActivityIndicatorView()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let gesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
    }
    
    //MARK: ViewSafeAreaInsetsDidChange
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setupUI()
        dismissButtonSetUp()
    }
    
    //MARK: DismissButton Settings
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
    private func setupUI() {
        welcomeLabel.text = "피보호자 정보 입력"
        welcomeLabel.font = UIFont(name: "Arial", size: 22)
        welcomeLabel.textColor = .black
        welcomeLabel.textAlignment = .center
        view.addSubview(welcomeLabel)
        
        nameTextField.layer.borderColor = UIColor.gray.cgColor
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.cornerRadius = 4
        nameTextField.placeholder = "피보호자의 이름을 입력해주세요."
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTextField.frame.height))
        nameTextField.leftView = paddingView
        nameTextField.leftViewMode = .always
        nameTextField.keyboardType = .emailAddress
        nameTextField.autocapitalizationType = .none
        nameTextField.autocorrectionType = .no
        view.addSubview(nameTextField)
        
        nameCheckLabel.text = "예) 홍길동"
        nameCheckLabel.font = UIFont(name: "Arial", size: 13)
        view.addSubview(nameCheckLabel)
        
        phoneNumberTextField.layer.borderColor = UIColor.gray.cgColor
        phoneNumberTextField.layer.borderWidth = 1
        phoneNumberTextField.layer.cornerRadius = 4
        phoneNumberTextField.placeholder = "피보호자의 연락처를 입력해주세요."
        let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: phoneNumberTextField.frame.height))
        phoneNumberTextField.leftView = paddingView2
        phoneNumberTextField.leftViewMode = .always
        phoneNumberTextField.keyboardType = UIKeyboardType.numberPad
        view.addSubview(phoneNumberTextField)
        
        phoneNumberCheckLabel.text = "- 를 제외하고 입력해주세요. 예)01012345678"
        phoneNumberCheckLabel.font = UIFont(name: "Arial", size: 13)
        view.addSubview(phoneNumberCheckLabel)
       
        signUpButton.setTitle("시작하기", for: .normal)
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
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameCheckLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberCheckLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        activitiyIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            welcomeLabel.widthAnchor.constraint(equalToConstant: 200),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 50),
            
            nameTextField.topAnchor.constraint(equalTo: welcomeLabel.topAnchor, constant: 100),
            nameTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 320),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameCheckLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 5),
            nameCheckLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: 3),
            
            phoneNumberTextField.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor, constant: 100),
            phoneNumberTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            phoneNumberTextField.widthAnchor.constraint(equalToConstant: 320),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            phoneNumberCheckLabel.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 5),
            phoneNumberCheckLabel.leadingAnchor.constraint(equalTo: phoneNumberTextField.leadingAnchor, constant: 3),
            
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            signUpButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 320),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            activitiyIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activitiyIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            activitiyIndicator.widthAnchor.constraint(equalToConstant: 30),
            activitiyIndicator.heightAnchor.constraint(equalToConstant: 30),
        ])
        activitiyIndicator.isHidden = true
        activitiyIndicator.style = .large
    }
    
    //MARK: SignUpEvent
    @objc private func signupEvent() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var elderCode = ""
        var count = 0
        
        for i in uid {
            count += 1
            elderCode.append(i)
            if count == 6 {
                break
            }
        }
        count = 0
        
        var helperNames = ""
        var helperPhoneNumbers = ""
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { snapshop in
            let datas = snapshop.value as? [String:Any] ?? ["fail":"fail"]
            print(datas)
            guard let helperName = datas["userName"] as? String else { return }
            guard let helperPhoneNumber = datas["phoneNumber"] as? String else { return }
            
            helperNames = helperName
            helperPhoneNumbers = helperPhoneNumber
            print(helperNames, helperPhoneNumbers)
            let values = ["ElderName": self.nameTextField.text ?? "noname",
                          "ElderPhoneNumber": self.phoneNumberTextField.text ?? "wrongNumber",
                          "ElderCode": elderCode,
                          "HelperName": helperNames,
                          "HelperPhoneNumber": helperPhoneNumbers
                ] as [String : Any]
            Database.database().reference().child("users").child(elderCode).setValue(values) { (err, ref) in
                if err == nil {
                    print("ElderCode Child maked")
                } else {
                    print("ElderCode Child make fail.")
                }
            }
            UserDefaults.standard.set(elderCode, forKey: "elderCode")
            Database.database().reference().child("users").child(uid).child("ElderInfo").setValue(values) { (err, ref) in
                if err == nil && self.nameTextField.text?.count ?? 0 >= 2 && self.phoneNumberTextField.text?.count ?? 0 == 11 {
                    print("피보호자 정보 저장 완료. 회원가입 완료.")
                    let helperSignUpFinishVC = HelperSignUpFinishViewController()
                    helperSignUpFinishVC.modalPresentationStyle = .fullScreen
                    self.present(helperSignUpFinishVC, animated: true)
                } else {
                    print("회원가입 실패")
                    self.activitiyIndicator.isHidden = true
                    self.activitiyIndicator.stopAnimating()
                    self.failEvent()
                }
            }
        }
    }
    
    
    private func failViewSetUp() {
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
    
    
    private func failEvent() { // 로그인 실패시 이벤트
        let centerOrigin = self.nameTextField.center.x
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                self.failViewName.alpha = 1.5
                self.failViewPhone.alpha = 1.5
                
                self.nameTextField.center.x -= 25
                self.failViewName.center.x -= 25
                
                self.phoneNumberTextField.center.x -= 25
                self.failViewPhone.center.x -= 25
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                self.nameTextField.center.x += 35
                self.failViewName.center.x += 35
                
                self.phoneNumberTextField.center.x += 35
                self.failViewPhone.center.x += 35
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2) {
                self.nameTextField.center.x -= 25
                self.failViewName.center.x -= 25
                
                self.phoneNumberTextField.center.x -= 25
                self.failViewPhone.center.x -= 25
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self.nameTextField.center.x += 35
                self.failViewName.center.x += 35
                
                self.phoneNumberTextField.center.x += 35
                self.failViewPhone.center.x += 35
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                self.nameTextField.center.x -= 25
                self.failViewName.center.x -= 25
                
                self.phoneNumberTextField.center.x -= 25
                self.failViewPhone.center.x -= 25
            }
            UIView.addKeyframe(withRelativeStartTime: 0.95, relativeDuration: 0.2) {
                self.nameTextField.center.x += 35
                self.nameTextField.center.x = centerOrigin
                self.failViewName.center.x += 35
                self.failViewName.center.x = centerOrigin
                
                self.phoneNumberTextField.center.x += 35
                self.phoneNumberTextField.center.x = centerOrigin
                self.failViewPhone.center.x += 35
                self.failViewPhone.center.x = centerOrigin
                
                self.failViewName.alpha = 0.0
                self.failViewPhone.alpha = 0.0
            }
        })
    }
}


extension HelperSignUpSecondViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            phoneNumberTextField.becomeFirstResponder()
        } else {
            phoneNumberTextField.resignFirstResponder()
            signupEvent()
        }
        return true
    }
}
