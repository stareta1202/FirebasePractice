//
//  TestPageViewController.swift
//  YGFirebaseTest
//
//  Created by Yongjun Lee on 2021/03/04.
//

import UIKit
import SnapKit
import Firebase

class TestPageViewController: UIViewController {
    var button = UIButton.custumButton()
    var secondButton = UIButton.custumButton()
    var printButton = UIButton.custumButton()
    
    var textField = UITextField()
    var otherTextField = UITextField()
    var ref: DatabaseReference!
    
    
    var date = Date()
    var minuteFormatter = DateFormatter()
    var hourFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        ref = Database.database().reference()
        
        view.add(button) {
            $0.setTitle("updateChildValues", for: .normal)
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
        view.add(secondButton) {
            $0.setTitle("트랜젝션 텟", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(270)
            }
        }
        view.add(printButton) {
            $0.setTitle("스테이지8세팅 버튼", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(12)
            }
            $0.addTarget(self, action: #selector(self.stage8), for: .touchUpInside)

        }
    }
    @objc func action() {
        ref.child("test").observe(.childAdded) { (snapshot) in
//            self.ref.child("tes
            
        }
        
    }
    @objc func secondAction() {

    }
    
    @objc func printValue() {
        var count = Int()
        
        var date = Date()
        var minuteFormatter = DateFormatter()
        var hourFormatter = DateFormatter()

        hourFormatter.dateFormat = "HH"
        minuteFormatter.dateFormat = "mm"
        
        var currentMinuteString = minuteFormatter.string(from: Date())
        var currentHourString = hourFormatter.string(from: Date())
        
        ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
        if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {

            print("post:", post)

            var stage4: Dictionary<String, AnyObject>
            stage4 = post["stage4"] as? [String : AnyObject] ?? [:]
            
            var timeJson: Dictionary<String, AnyObject>
            timeJson = stage4["json"] as? [String: AnyObject] ?? [:]
            
            var timeDic: Dictionary<String, AnyObject>
            timeDic = timeJson[currentHourString] as? [String: AnyObject] ?? [:]
            
            var userCount = timeDic[currentMinuteString] as? Int ?? 0

            if let _ = timeDic[currentMinuteString] {
            } else {
                timeDic[currentMinuteString] = userCount as AnyObject
                userCount += 1
            }
            if let _ = stage4[uid] {
                if let _ = timeJson[currentHourString] {
                } else {
                    timeJson[currentHourString] = timeDic as AnyObject
                }
            } else {
                // Star the post and add self to stars
//                userCount += 1
//                stage4[uid] = true as AnyObject
            }
            stage4["json"] = timeJson as AnyObject?
            post["userCount"] = userCount as AnyObject?
            post["stage4"] = stage4 as AnyObject?
            currentData.value = post
          return TransactionResult.success(withValue: currentData)
        }
        return TransactionResult.success(withValue: currentData)
      }) { (error, committed, snapshot) in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
    @objc func stage8() {
        for hour in 0 ..< 24 {
            for minute in 0 ..< 60 {
                ref.child("stage8/json/\(hour)/\(minute)").setValue(["flag": false, "number":0])
            }
        }
    }
    private func observing() {
        
    }

}
