//
//  StageSevenViewController.swift
//  YGFirebaseTest
//
//  Created by Yongjun Lee on 2021/03/05.
//


import UIKit
import SnapKit
import Firebase

class StageSevenViewController: UIViewController {
    var button = UIButton.custumButton()
    var printButton = UIButton.custumButton()
    var textField = UITextField()
    var targetLabel = UILabel()
    var otherTextField = UITextField()
    var stage7Ref = Database.database().reference().child("stage7")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        print("7 stage")
        observing()
        view.add(button) {
            $0.setTitle("Conver to Lowcase", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(12)
            }
        }

        view.add(targetLabel) {
            $0.text = "빈라벨"
            $0.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(182)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.stage7Ref.removeAllObservers()
    }
    
    private func observing() {
        print("hihi")
        self.stage7Ref.child("message").observe(.value) { (snapshot) in
            if let snap = snapshot.value as? [String: String] {
                print("snap is", snap)
            }
            for index in snapshot.children {
                let sanp = index as! DataSnapshot
                var tempStr = sanp.value as! String
                print("indexval:", sanp.value as! String)
                print("indexstr:", sanp.key as! String)
                var lowedStr = tempStr.lowercased()
                self.stage7Ref.child("message/\(sanp.key)").setValue(lowedStr)
            }
        }
    }
}

