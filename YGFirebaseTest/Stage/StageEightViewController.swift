//
//  StageEightViewController.swift
//  YGFirebaseTest
//
//  Created by Yongjun Lee on 2021/03/05.

import UIKit
import SnapKit
import Firebase

class StageEightViewController: UIViewController {
    var button = UIButton.custumButton()
    var printButton = UIButton.custumButton()
    var textField = UITextField()
    var targetLabel = UILabel()
    var otherTextField = UITextField()
    var stage8Ref = Database.database().reference().child("stage8")
    var mTimer = Timer()
    
    var flag = Bool()
    var number = Int()
    
    var activeHour = Int()
    var activeMinute = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        print("8 stage")
        tempFunc()
//        observingOnce()
//        updating()
//        updatingByUpdate
//        observing()
        view.add(button) {
            $0.setTitle("updating", for: .normal)
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
        view.add(printButton) {
            $0.setTitle("make flag true", for: .normal)
            $0.backgroundColor = .blue
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().inset(32)
            }
            $0.addTarget(self, action: #selector(self.settingTemp), for: .touchUpInside)

        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.stage8Ref.removeAllObservers()
        
        if mTimer.isValid {
            mTimer.invalidate()
        }
    }
    private func updatingByUpdate() {
        var currentHour = Calendar.current.component(.hour, from: Date())
        var currentMinute = Calendar.current.component(.minute, from: Date())
        
        self.stage8Ref.child("json/\(currentHour)/\(currentMinute)").observe(.value) { (snapshot) in
            print(snapshot.value) // ok 통과
            if var dic = snapshot.value as? [String: AnyObject] {
                print(dic)
                self.flag = dic["flag"] as! Bool
                self.number = dic["number"] as! Int
            }
        }
        
        if mTimer.isValid {
            mTimer.invalidate()
        }
        mTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            
            print("timer is working")
            print(self.flag, self.number)
            if currentHour != Calendar.current.component(.hour, from: Date()) {
                currentHour = Calendar.current.component(.hour, from: Date())
            }
            if currentMinute != Calendar.current.component(.minute, from: Date()){
                currentMinute = Calendar.current.component(.minute, from: Date())
            }
            if self.flag {
                self.number += 1
            }
            
            self.stage8Ref.child("json/\(currentHour)/\(currentMinute)").updateChildValues(["number":self.number as AnyObject] )
        })

    }
    
    
    
    
    func tempFunc() {
        
        if mTimer.isValid {
            mTimer.invalidate()
        }
        
        mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(obcTempFunc), userInfo: nil, repeats: true)
    }
    
    @objc func obcTempFunc() {
        var date = Date()
        self.stage8Ref.child("json/\(Calendar.current.component(.hour, from: Date()))/\(Calendar.current.component(.minute, from: Date()))").runTransactionBlock { (currentData: MutableData) -> TransactionResult in
            if var post = currentData.value as? [String: AnyObject]{
                print(post)
                self.number = post["number"] as! Int ?? 0
                self.flag = post["flag"] as! Bool
                if self.flag {
                    self.number += 1
                }
                print("number is?", self.number)
                
//                post["number"] = self.number as AnyObject?
                post["number"] = self.number as AnyObject?
                currentData.value = post
                
            }
            return TransactionResult.success(withValue: currentData)
        } andCompletionBlock: { (error, commit, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }

    }
    
    
    func observing() {
        self.stage8Ref.child("json/\(Calendar.current.component(.hour, from: Date()))/\(Calendar.current.component(.minute, from: Date()))").observe(.value) { (snapshot) in
            print(snapshot.value)
            
            for index in snapshot.children {
                let snap = index as! DataSnapshot
                print(snap.key, snap.value)
            }
        }
        
    }
    private func updating() {
        
        self.stage8Ref.child("json/\(Calendar.current.component(.hour, from: Date()))/\(Calendar.current.component(.minute, from: Date()))").runTransactionBlock { (snapshot: MutableData) -> TransactionResult in
            
            print("observe",snapshot.value)
            return TransactionResult.success(withValue: snapshot)
            
        } andCompletionBlock: { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    @objc func settingTemp() {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
        self.stage8Ref.child("json/\(Calendar.current.component(.hour, from: Date()))/\(Calendar.current.component(.minute, from: Date()))").child("flag").setValue(true)
//        self.stage8Ref.child("json/\(Calendar.current.component(.hour, from: Date()))/\(Calendar.current.component(.minute, from: Date()))").child("number").setValue(Int(dateFormatter.string(from: Date())))
        
//        print(dateFormatter.string(from: Date()))
    }
}

