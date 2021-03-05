//
//  StageNineViewController.swift
//  YGFirebaseTest
//
//  Created by Yongjun Lee on 2021/03/05.
//

import UIKit
import SnapKit
import Firebase

class StageNineViewController: UIViewController {
    var button = UIButton.custumButton()
    var printButton = UIButton.custumButton()
    var textField = UITextField()
    var targetLabel = UILabel()
    var otherTextField = UITextField()
    var stage9Ref = Database.database().reference().child("stage9")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        print("9 stage")
        
        observing()
        
        view.add(button) {
            $0.setTitle("Converting Datatype", for: .normal)
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
        self.stage9Ref.removeAllObservers()
    }
    
    private func observing() {
        self.stage9Ref.child("value").observe(.value) { (snapshot) in
            print("snapshot value is", snapshot.value)
            if var id = snapshot.value as? String {
                print("it is string", id)
                self.stage9Ref.child("type").setValue("String")
            } else if var idd = snapshot.value as? Int {
                print("it is int", idd)
                self.stage9Ref.child("type").setValue("Int")
            } else {
                print("error")
            }
        }
    }

    
}
