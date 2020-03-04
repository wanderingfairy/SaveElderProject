//
//  ElderSignUpViewController.swift
//  SaveElderProject
//
//  Created by Demian on 2020/01/15.
//  Copyright © 2020 Demian. All rights reserved.
//

import UIKit
import Firebase

class ElderSignUpViewController: UIViewController {
    
        //MARK: 변수 선언
    var ref: DatabaseReference!
    
    let activitiyIndicator = UIActivityIndicatorView()
    let failViewCode = UIView()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        ref = Database.database().reference() // 서버에서 데이터 받아오기
        let gesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(gesture)
        
    }
    
    //MARK: ViewSafeAreaInsetsDidChange
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        setupUI()
        dismissButtonSetUp()
        
    }
    
    //MARK: Dismiss Button Setup
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
    
    //MARK: DIdTap Dismiss
    @objc private func didTapDismiss(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    //MARK: SetupUI
    private func setupUI() {
        view.addSubview(explainLabel)
        view.addSubview(codeInputTextField)
        view.addSubview(signInButton)
        view.addSubview(errorLabel)
        view.addSubview(activitiyIndicator)
        
        let standardView = view.safeAreaLayoutGuide
        explainLabel.layout.top(equalTo: standardView.topAnchor, constant: 80).centerX()
        explainLabel.widthAnchor.constraint(equalTo: standardView.widthAnchor).isActive = true
        explainLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        explainLabel.alpha = 0.0
        UIView.animate(withDuration: 1.5) {
            self.explainLabel.center.x -= 50
            self.explainLabel.alpha = 1.0
        }
        
        
        codeInputTextField.layout.top(equalTo: explainLabel.bottomAnchor, constant: 20).centerX()
        codeInputTextField.widthAnchor.constraint(equalToConstant: 320).isActive = true
        codeInputTextField.heightAnchor.constraint(equalToConstant: 80).isActive = true
        codeInputTextField.delegate = self
        
        errorLabel.layout.top(equalTo: codeInputTextField.bottomAnchor, constant: 25).centerX()
        errorLabel.widthAnchor.constraint(equalTo: standardView.widthAnchor, multiplier: 0.8).isActive = true
        
        signInButton.layout.top(equalTo: codeInputTextField.bottomAnchor, constant: 80).centerX()
        signInButton.widthAnchor.constraint(equalToConstant: 320).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signInButton.addTarget(self, action: #selector(elderLogInEvent(_:)), for: .touchUpInside)
        
        
        activitiyIndicator.layout.centerX(equalTo: errorLabel.centerXAnchor).centerY(equalTo: errorLabel.centerYAnchor)
        activitiyIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        activitiyIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
        activitiyIndicator.isHidden = true
        activitiyIndicator.style = .large
        
        failViewSetUp()
        
    }
    
    //MARK: ElderLogInEvent
    @objc private func elderLogInEvent(_ sender: UIButton) {
        
        UIView.animate(withDuration: 2.0) {
            self.activitiyIndicator.isHidden = false
            self.activitiyIndicator.startAnimating()
        }
        if codeInputTextField.text?.count != 0 {
            guard let uidCode = codeInputTextField.text else { return }
            ref.child("users").child(uidCode).observeSingleEvent(of: .value) { snapshop in
                var elderDatas: [String : Any] = ["":""]
                
                elderDatas = snapshop.value as? [String:Any] ?? ["fail":0]
                guard let correctCode = elderDatas["ElderCode"] as? String else
                {
                    self.activitiyIndicator.isHidden = true
                    self.activitiyIndicator.stopAnimating()
                    self.failEvent()
                    
                    return
                }
                UserDefaults.standard.set(uidCode, forKey: "elderCode")
                
                if correctCode == uidCode { //로그인 성공
                    let elderMainVC = ElderMainViewController()
                    elderMainVC.modalPresentationStyle = .fullScreen
                    self.present(elderMainVC, animated: true)
                }
            }
        } else {
            self.activitiyIndicator.isHidden = true
            self.activitiyIndicator.stopAnimating()
            self.failEvent()
        }
    }

    //MARK: 로그인 실패 이벤트
    private func failViewSetUp() {
        view.addSubview(failViewCode)
        failViewCode.layer.borderColor = UIColor.red.cgColor
        failViewCode.layer.cornerRadius = 4
        failViewCode.layer.borderWidth = 3
        failViewCode.alpha = 0.0
        failViewCode.layout.centerX(equalTo: codeInputTextField.centerXAnchor).centerY(equalTo: codeInputTextField.centerYAnchor)
        failViewCode.widthAnchor.constraint(equalTo: codeInputTextField.widthAnchor).isActive = true
        failViewCode.heightAnchor.constraint(equalTo: codeInputTextField.heightAnchor).isActive = true
        
        
    }
    
    //MARK: FailEvent
    private func failEvent() { // 로그인 실패시 이벤트
        let centerOrigin = self.codeInputTextField.center.x
        UIView.animate(withDuration: 2.0) {
            self.errorLabel.alpha = 1.0
            self.errorLabel.alpha = 0.0
        }
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                self.failViewCode.alpha = 1.5
                
                self.codeInputTextField.center.x -= 25
                self.failViewCode.center.x -= 25
                
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                self.codeInputTextField.center.x += 35
                self.failViewCode.center.x += 35
            
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2) {
                self.codeInputTextField.center.x -= 25
                self.failViewCode.center.x -= 25
                
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self.codeInputTextField.center.x += 35
                self.failViewCode.center.x += 35
                
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                self.codeInputTextField.center.x -= 25
                self.failViewCode.center.x -= 25
                
            }
            UIView.addKeyframe(withRelativeStartTime: 0.95, relativeDuration: 0.2) {
                self.codeInputTextField.center.x += 35
                self.codeInputTextField.center.x = centerOrigin
                self.failViewCode.center.x += 35
                self.failViewCode.center.x = centerOrigin
                
              
                self.failViewCode.alpha = 0.0
                
            }
        })
    }
    
    
    //MARK: UI AutoLayout
    private let explainLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "안녕하세요.\n\n문자 혹은 보호자에게 \n받은 코드를 입력하세요"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        return label
    }()
    
    
    //MARK: CodeInputTextField
    private var codeInputTextField: UITextField = {
        let textField = UITextField()
        let attrString = NSAttributedString(string: "보호자 코드를 입력하세요", attributes: [.foregroundColor: UIColor.darkText.withAlphaComponent(0.5)])
        let idPaddinView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: textField.frame.height))
        textField.attributedPlaceholder = attrString
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 4
        textField.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        textField.textAlignment = .center
        textField.enablesReturnKeyAutomatically = true
        textField.borderStyle = .none
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.leftView = idPaddinView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    
    //MARK: SignInButton
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "mypink")
        button.setTitle("시작하기", for: .normal)
        button.layer.cornerRadius = 4
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        button.shadow()
        
        return button
    }()
    
    //MARK: ErrorLabel Setting
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "코드를 확인해주세요"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .black)
        label.alpha = 0.0
        
        return label
        
    }()
}


//MARK: Extension : UITextFieldDelegate
extension ElderSignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == codeInputTextField {
            codeInputTextField.resignFirstResponder()
            elderLogInEvent(signInButton)
        }
        return true
    }
}
