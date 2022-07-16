import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailOrPhoneNumberField: UITextField!
    @IBOutlet weak var passWordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var codeField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var toggle: UISwitch!
    
    @IBOutlet var textFieldCollection: [UITextField]!
    
    var checkCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        updateLabelUI()
        updateTextFieldUI()
        updateButtonUI()
        updateToggleUI()
    }
    
    func updateLabelUI() {
        informationLabel.text = "추가 정보 입력"
        informationLabel.textColor = .white
        informationLabel.font = .boldSystemFont(ofSize: 15)
    }
    
    func updateTextFieldUI() {
        //아울렛 컬렉션으로 대체
        //let textFieldList = [emailOrPhoneNumberField, passWordField, nameField, locationField, codeField]
        
        emailOrPhoneNumberField.placeholder = "이메일 주소 또는 전화번호"
        emailOrPhoneNumberField.keyboardType = .default
        passWordField.placeholder = "비밀번호"
        passWordField.isSecureTextEntry = true
        nameField.placeholder = "닉네임"
        locationField.placeholder = "위치"
        codeField.placeholder = "추천 코드 입력"
        
        for i in textFieldCollection {
            // guard let i = i else { return }
            i.textAlignment = .left
            i.keyboardType = .default
            i.layer.masksToBounds = true
            i.layer.cornerRadius = 3
            i.layer.borderWidth = 1
            i.layer.borderColor = UIColor.systemGray.cgColor
            i.backgroundColor = UIColor.darkGray
            i.textColor = .white
            i.attributedPlaceholder = NSAttributedString(string:i.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray3])
        }
    }
    
    
    func updateButtonUI() {
        //signUpButton.configuration = nil // 작성 시 Default가 아닌 Style에서도 폰트 두께 수정 가능, 임시 방편이다.
        signUpButton.setTitle("회원가입", for: .normal)
        //signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 100) // 작동 안됨, Button style 有关
        
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.setTitleColor(.gray, for: .highlighted)
        signUpButton.backgroundColor = .white
        signUpButton.layer.masksToBounds = true
        signUpButton.layer.cornerRadius = 5
    }
    
    func updateToggleUI() {
        toggle.setOn(true, animated: true)
        toggle.onTintColor = .systemOrange
        toggle.thumbTintColor = .white
    }
    
    @IBAction func tabCloseKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        view.endEditing(true)
        checkCount = 0
        checkList()
        
        if checkCount > 0 {
            alret(title: "회원가입 오류", message: "오류가 발생했습니다.")
        } else {
            let alert = UIAlertController(title: "회원가입 완료", message: "회원가입이 완료되었습니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default) { _ in
                self.performSegue(withIdentifier: "SignUp", sender: self)
            }
            present(alert, animated: true, completion: nil)
            alert.addAction(ok)
        }
    }
    
    @IBAction func unwindToSignUpViewController(segue: UIStoryboardSegue){
        
    }
    func checkList() {
        // 조건1. 이메일 비밀번호 입력 필수
        // 조건2. 비밀번호 최소 6자리 이상
        // 조건3. 추천 코드는 숫자만 입력
        
        guard let text = emailOrPhoneNumberField.text else { return }
        if text.isEmpty {
            checkCount += 1
            placeholderTextField(sender: emailOrPhoneNumberField, text: "이메일 또는 아이디를 입력하세요.")
//            alret(message: "오류가 발생했습니다.")
        }
        
        guard let passWordCount = passWordField.text?.count else { return }
        if passWordCount < 6 {
            checkCount += 1
            placeholderTextField(sender: passWordField, text: "비밀번호는 최소 6자리입니다.")
//            alret(message: "오류가 발생했습니다.")
        }
        
        guard let code = codeField.text else { return }
        if Int(code) == nil {
            checkCount += 1
            placeholderTextField(sender: codeField, text: "숫자로만 입력 가능합니다.")
//            alret(message: "오류가 발생했습니다.")
        }
    }

    // 조건에 맞지 않을 때 placeholder 내용 갱신
    func placeholderTextField(sender: UITextField, text: String) {
        sender.text = ""
        sender.placeholder = text
        sender.attributedPlaceholder = NSAttributedString(string: sender.placeholder ?? text, attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemRed])
        print("오류: \(text)")
    }
    
    func alret(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
}

