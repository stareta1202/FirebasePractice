//
//  StageFourViewController.swift
//  YGFirebaseTest
//
//  Created by Yongjun Lee on 2021/03/04.
//

import UIKit
import SnapKit
import Firebase

class StageFourViewController: UIViewController {
    var button = UIButton.custumButton()
    var printButton = UIButton.custumButton()
    var textField = UITextField()
    var ref: DatabaseReference!
    var timer: Timer?
    var globalCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        ref = Database.database().reference()
        
        view.add(button) {
            $0.setTitle("action", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(12)
            }
            $0.addTarget(self, action: #selector(self.timerStart(_:)), for: .touchUpInside)
        }
        view.add(textField) {
            $0.placeholder = "값 입력하세요"
            $0.keyboardType = .default
            $0.autocapitalizationType = .none
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(112)
            }

        }
        view.add(printButton) {
            $0.setTitle("print", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(212)
            }
            $0.addTarget(self, action: #selector(self.printValue), for: .touchUpInside)
        }
    }
    //타이머 관련
    @objc func timerStart(_ sender: UIButton) {
        if let timer = timer {
            if !timer.isValid {
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.action), userInfo: nil, repeats: true)
            }
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.action), userInfo: nil, repeats: true)
        }
    }
    // 버튼 눌렀을 때
    
    @objc func action() {
        globalCount = 1
        print(globalCount)
        var minuteFormatter = DateFormatter()
        var hourFormatter = DateFormatter()

        hourFormatter.dateFormat = "HH"
        minuteFormatter.dateFormat = "mm"
        
        var currentMinuteString = minuteFormatter.string(from: Date())
        var currentHourString = hourFormatter.string(from: Date())
        
        ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
        if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {

//            print("post:", post)

            var stage4: Dictionary<String, AnyObject>
            stage4 = post["stage4"] as? [String : AnyObject] ?? [:]
            
            var timeJson: Dictionary<String, AnyObject>
            timeJson = stage4["json"] as? [String: AnyObject] ?? [:]
            
            var timeDic: Dictionary<String, Int>
            timeDic = timeJson[currentHourString] as? [String: Int] ?? [:]
            
            var userCount = timeDic[currentMinuteString] as? Int ?? 0

            if let _ = timeDic[currentMinuteString] {
//                timeDic[currentMinuteString]! += globalCount as Int
                userCount += 1

            } else {
                timeDic[currentMinuteString] = 0 as Int
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
            timeDic[currentMinuteString]! += self.globalCount as Int
            timeJson[currentHourString] = timeDic as AnyObject?
            stage4["json"] = timeJson as AnyObject?
//            post["userCount"] = userCount as AnyObject?
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
    @objc func printValue() {
        print("hi")
    }

}

