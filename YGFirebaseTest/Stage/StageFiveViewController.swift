//
//  StageFiveViewController.swift
//  YGFirebaseTest
//
//  Created by Yongjun Lee on 2021/03/04.
//

import UIKit
import SnapKit
import Firebase

class StageFiveViewController: UIViewController {
    var button = UIButton.custumButton()
    var printButton = UIButton.custumButton()
    var textField = UITextField()
    var targetLabel = UILabel()
    var otherTextField = UITextField()
    var ref: DatabaseReference!
    var stage5Ref = Database.database().reference().child("stage5")
    
    var tempName = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        ref = Database.database().reference()
        
        //먼저 타겟에 이름이 있는지 없는지
        self.stage5Ref.child("target").observeSingleEvent(of: .value) { (snapshot) in
            if let name = snapshot.value as? [String: Any], let valueOfName = name["name"] as? String {
                self.tempName = valueOfName
                self.targetLabel.text = valueOfName
                print(name)
                print(valueOfName)
            } else {
                self.targetLabel.text = "nothing"
            }
        }
        //유저에 타겟이 있는지 없는지확인
        self.stage5Ref.child("user").observeSingleEvent(of: .value) { (snapshot) in
            let dic = snapshot.value as! [String: Any]
            for index in dic {
                if index.key == self.tempName {
                    self.targetLabel.text = index.value as! String
                }
            }
        }
        
        //추후에 타겟이 바뀌는지 안바뀌는 지
        self.stage5Ref.child("target").observe(.childChanged) { (snapshot) in
            let changedName = snapshot.value as! String
            print(snapshot.value)
            self.stage5Ref.child("user").observeSingleEvent(of: .value) { (dataSnapshot) in
                let dic = dataSnapshot.value as! [String: Any]
                for index in dic {
                    if index.key == changedName {
                        self.targetLabel.text = index.value as! String
                    }
                }
            }
            
        }
//        self.stage5Ref.observeSingleEvent(of: .value) { (snapshot) in
//            let data = snapshot.value as? [String:Any]
//            print(2020, data as? [String:Any])
//            if let target = data {
//                print(12222, target)
//            } else {
//                print("it doesnt exist")
//            }
//            print(3030, data?["sa"] as? String)
//        }
//        self.stage5Ref.observe(.childChanged) { (other) in
//            print(other)
//        }
        view.add(button) {
            $0.setTitle("이름 바꾸기", for: .normal)
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
//        view.add(otherTextField) {
//            $0.placeholder = "밸류 값 입력하세요"
//            $0.keyboardType = .default
//            $0.autocapitalizationType = .none
//            $0.snp.makeConstraints { (make) in
//                make.centerX.equalToSuperview()
//                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(182)
//            }
//
//        }
        view.add(targetLabel) {
            $0.text = "빈라벨"
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
    // ? 함수로 한번만 실행이 되는 것인데 옵저빙이 가능할까..?
    @objc func action() {

        self.targetLabel.text = ""
    }
    @objc func printValue() {
        print("hi")
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

