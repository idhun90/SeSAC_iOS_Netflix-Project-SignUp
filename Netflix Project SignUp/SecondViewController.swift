//
//  SecondViewController.swift
//  Netflix Project SignUp
//
//  Created by 이도헌 on 2022/07/16.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var OkButton: UIButton!
    
    override func viewDidLoad() {
        let nickName = UserDefaults.standard.string(forKey: "nickName") ?? "회원님"
        
        super.viewDidLoad()
        designOkButton()
        resultLabel.text = "\(nickName)님 회원가입을 축하드립니다."
        resultLabel.textColor = .white
        view.backgroundColor = .black
    }
    
    func designOkButton() {
        OkButton.layer.masksToBounds = true
        OkButton.layer.cornerRadius = 5
        OkButton.setTitle("확인", for: .normal)
        OkButton.setTitleColor(.black, for: .normal)
        OkButton.setTitleColor(.gray, for: .highlighted)
        OkButton.backgroundColor = .white
    }
}
