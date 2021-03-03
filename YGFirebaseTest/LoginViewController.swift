//
//  LoginViewController.swift
//  YGFirebaseTest
//
//  Created by Yongjun Lee on 2021/03/03.
//

import UIKit
import SnapKit
import Firebase

class LoginViewController: UIViewController {
    var mainLabel = UILabel()
    var emailField = UITextField()
    var passwordField = UITextField()
    var loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
//        if let user = Auth.auth().currentUser {
//            emailField.placeholder = "이미 로그인 된 상태입니다."
//            passwordField.placeholder " 이미 로그인 된 상태입니다."
//            loginButton.setTitle("x", for: .disabled)
//        }

        initView()
    }
    
    private func initView() {
        self.view.add(mainLabel) {
            $0.text = "로그인 하세요"
            $0.textColor = .black
            $0.sizeToFit()
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(64)
            }
        }
        self.view.add(emailField) {
            $0.placeholder = "아이디를 입력하세요"
            $0.keyboardType = .emailAddress
            $0.autocapitalizationType = .none
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.leading.equalToSuperview().offset(64)
                make.trailing.equalToSuperview().inset(64)
                make.top.equalTo(self.mainLabel.snp.bottom).offset(128)
            }
            self.underLineViewLayout(textField: $0)
        }
        self.view.add(passwordField) {
            $0.placeholder = "비밀번호를 입력하세요"
            $0.isSecureTextEntry = true
            $0.autocapitalizationType = .none
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.leading.equalToSuperview().offset(64)
                make.trailing.equalToSuperview().inset(64)
                make.top.equalTo(self.emailField).offset(48)
            }
            self.underLineViewLayout(textField: $0)
        }
        self.view.add(loginButton) {
            $0.setTitle("Login", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .lightGray
            $0.layer.cornerRadius = 16
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.leading.equalTo(self.passwordField.snp.leading).offset(32)
                make.trailing.equalTo(self.passwordField.snp.trailing).inset(32)
                make.top.equalTo(self.passwordField.snp.bottom).offset(64)
            }
            $0.addTarget(self, action: #selector(self.login), for: .touchUpInside)
        }
    }
    func underLineViewLayout(textField: UITextField) {
        let underLineView = UIView()
        self.view.add(underLineView) {
            $0.backgroundColor = .lightGray
            $0.snp.makeConstraints { (make) in
                make.height.equalTo(0.5)
                make.leading.equalTo(textField.snp.leading)
                make.trailing.equalTo(textField.snp.trailing)
                make.top.equalTo(textField.snp.bottom).offset(12)
            }
        }
    }
    @objc func login() {
        print("button pressed")
        guard let emailText = emailField.text else {
            return
        }
        guard let passwordText = passwordField.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { (user, error) in
            if user != nil {
                print("success")
                self.successAlert()
                
            } else {
                self.failedAlert()
            }
        }
        
    }
    func failedAlert() {
        let alertVC = UIAlertController(title: nil, message: "다시 입력해주세요", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    func successAlert() {
        
        self.present(MainViewController(), animated: true, completion: nil)
        
    }
    private func isLoginValid() {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
