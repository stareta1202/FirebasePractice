//
//  ViewController.swift
//  YGFirebaseTest
//
//  Created by Yongjun Lee on 2021/03/03.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {
    var stage1Button: UIButton = .custumButton()
    var stage2Button: UIButton = .custumButton()
    var stage3Button: UIButton = .custumButton()
    var stage4Button: UIButton = .custumButton()
    var stage5Button: UIButton = .custumButton()
    var stage6Button: UIButton = .custumButton()
    var stage7Button: UIButton = .custumButton()
    var stage8Button: UIButton = .custumButton()
    var stage9Button: UIButton = .custumButton()
    var testButton: UIButton = .custumButton()
    
    var explainLabel: UILabel = UILabel()


    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .fullScreen
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        initView()
        
    }
    
    private func initView() {
        
        view.add(stage1Button) {
            $0.setTitle("stage1", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(12)
            }
            $0.addTarget(self, action: #selector(self.showStageOne), for: .touchUpInside)
        }
        view.add(stage2Button) {
            $0.setTitle("stage2", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.stage1Button.snp.bottom).offset(12)
            }
            $0.addTarget(self, action: #selector(self.showStageTwo), for: .touchUpInside)

        }
        view.add(stage3Button) {
            $0.setTitle("stage3", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.stage2Button.snp.bottom).offset(12)
            }
            $0.addTarget(self, action: #selector(self.showStageThree), for: .touchUpInside)

        }
        view.add(stage4Button) {
            $0.setTitle("stage4", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.stage3Button.snp.bottom).offset(12)
            }
            $0.addTarget(self, action: #selector(self.showStageFour), for: .touchUpInside)

        }
        view.add(stage5Button) {
            $0.setTitle("stage5", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.stage4Button.snp.bottom).offset(12)
            }
            $0.addTarget(self, action: #selector(self.showStageFive), for: .touchUpInside)

        }
        view.add(stage6Button) {
            $0.setTitle("stage6", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.stage5Button.snp.bottom).offset(12)
            }
            $0.addTarget(self, action: #selector(self.showStageSix), for: .touchUpInside)

        }
        view.add(stage7Button) {
            $0.setTitle("stage7", for: .normal)
            $0.backgroundColor = .red
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.stage6Button.snp.bottom).offset(12)
            }
            $0.addTarget(self, action: #selector(self.showStageSeven), for: .touchUpInside)

        }
        view.add(stage8Button) {
            $0.setTitle("stage8", for: .normal)
            $0.backgroundColor = .red
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.stage7Button.snp.bottom).offset(12)
            }
        }
        view.add(stage9Button) {
            $0.setTitle("stage9", for: .normal)
            $0.backgroundColor = .red
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.stage8Button.snp.bottom).offset(12)
            }
        }
        view.add(explainLabel) {
            $0.text = "애매하거나 모르는 것 빨강, 확실한 것 검정"
            $0.font = .systemFont(ofSize: 22)
            $0.snp.makeConstraints { (make) in
                make.trailing.leading.equalToSuperview()
                make.top.equalTo(self.stage9Button.snp.bottom).offset(12)
            }
        }
        view.add(testButton) {
            $0.setTitle("testButton", for: .normal)
            $0.backgroundColor = .blue
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.explainLabel.snp.bottom).offset(12)
            }
            $0.addTarget(self, action: #selector(self.showTestPage), for: .touchUpInside)

        }
        
        
    }
    
    private func updateView() {
        
    }
    @objc func showStageOne() {
        self.present(StageOneViewController(), animated: true, completion: nil)
    }
    @objc func showStageTwo() {
        self.present(StageTwoViewController(), animated: true, completion: nil)
    }
    @objc func showStageThree() {
        self.present(StageThreeViewController(), animated: true, completion: nil)
    }
    @objc func showStageFour() {
        self.present(StageFourViewController(), animated: true, completion: nil)
    }
    @objc func showStageFive() {
        self.present(StageFiveViewController(), animated: true, completion: nil)
    }
    @objc func showStageSix() {
        self.present(StageSixViewController(), animated: true, completion: nil)
    }
    @objc func showStageSeven() {
        self.present(StageSevenViewController(),animated: true, completion: nil)
    }
    
    
    
    
    
    @objc func showTestPage() {
        self.present(TestPageViewController(), animated: true, completion: nil)
    }

}

