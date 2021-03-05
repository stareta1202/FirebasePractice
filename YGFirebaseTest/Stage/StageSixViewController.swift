//
//  StageSixViewController.swift
//  YGFirebaseTest
//
//  Created by Yongjun Lee on 2021/03/04.
//


import UIKit
import SnapKit
import Firebase

class StageSixViewController: UIViewController {
    var button = UIButton.custumButton()
    var printButton = UIButton.custumButton()
    var textField = UITextField()
    var targetLabel = UILabel()
    var otherTextField = UITextField()
    
    var stage6Ref = Database.database().reference().child("stage6")
    var count = 1
    var mTimer = Timer()
    
    var direction = String()
    var trigger = Bool()
    var counter = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.stage6Ref.child("alpha").observe(.value) { [self] (snapshot) in
            print("what is going with observ value")
            if var dic = snapshot.value as? [String : AnyObject] {
                print("dic", dic)
                self.counter = dic["counter"] as! Int
                self.trigger = dic["trigger"] as! Bool
                self.direction = dic["direction"] as! String
            }
            if mTimer.isValid {
                mTimer.invalidate()
            }
            mTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                if self.trigger {
                    if self.direction == "increase" {
                        self.counter += 1
                    } else if self.direction == "decrease" {
                        self.counter -= 1
                    } else {
                    }
                } else {
                }
                self.stage6Ref.child("alpha").updateChildValues(["counter":self.counter as AnyObject])
            })
        }

        view.add(button) {
            $0.setTitle("이름 바꾸기", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(12)
            }
//            $0.addTarget(self, action: #selector(self.action), for: .touchUpInside)
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
    
    override func viewWillDisappear(_ animated: Bool) {
        self.stage6Ref.removeAllObservers()
        print("옵저빙해제")
    }
    
    // ? 함수로 한번만 실행이 되는 것인데 옵저빙이 가능할까..?
    func action() {
        mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.nothing), userInfo: nil, repeats: self.trigger)

    }
    @objc func printValue() {
        print("hi")
    }

}

