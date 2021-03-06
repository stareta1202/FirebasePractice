//
//  StageThreeViewController.swift
//  YGFirebaseTest
//
//  Created by Yongjun Lee on 2021/03/03.
//
//

import UIKit
import SnapKit
import Firebase

class StageThreeViewController: UIViewController {
    var button = UIButton.custumButton()
    var printButton = UIButton.custumButton()
    var textField = UITextField()
    var otherTextField = UITextField()
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        ref = Database.database().reference()
        ref.child("stage3/setmessage")
        
        view.add(button) {
            $0.setTitle("키/밸류 버튼", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(12)
            }
            $0.addTarget(self, action: #selector(self.action), for: .touchUpInside)
        }
        view.add(textField) {
            $0.placeholder = "키값 입력하세요"
            $0.keyboardType = .default
            $0.autocapitalizationType = .none
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(112)
            }

        }
        view.add(otherTextField) {
            $0.placeholder = "밸류 값 입력하세요"
            $0.keyboardType = .default
            $0.autocapitalizationType = .none
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(182)
            }

        }
        view.add(printButton) {
            $0.setTitle("자동생성 버튼", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(270)
            }
            $0.addTarget(self, action: #selector(self.printValue), for: .touchUpInside)
        }
    }
    @objc func action() {

//        self.ref.child("stage3/setmessage").setValue([otherTextField.text : textField.text])
        self.ref.child("stage3/setmessage/\(textField.text!)").setValue(otherTextField.text)

        
    }
    @objc func printValue() {
        print("hi")
        ref.child("stage3/setmessage").childByAutoId().setValue(otherTextField.text)
        
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
