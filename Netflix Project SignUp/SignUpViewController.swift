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
        //signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 100) // 작동 안됨, Button style 有关, 정리 필요
        
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
        checkList()
    }
    
    func checkList () {
        
        // 조건1. 이메일 비밀번호 입력 필수
        // 조건2. 비밀번호 최소 6자리 이상
        // 조건3. 추천 코드는 숫자만 입력
        
        guard let text = emailOrPhoneNumberField.text else { return }
        if text.isEmpty {
            emailOrPhoneNumberField.text = "" // 사용자가 오류를 발견하고 다시 텍스트필드를 탭할 때 해당 문구 초기화 용도
            emailOrPhoneNumberField.placeholder = "이메일 또는 아이디를 입력하세요."
            emailOrPhoneNumberField.attributedPlaceholder = NSAttributedString.init(string: emailOrPhoneNumberField.placeholder ?? "이메일 또는 아이디를 입력하세요." , attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemRed])
            print("오류: 이메일 또는 아이디를 입력하세요.")
        }
        
        guard let passWordCount = passWordField.text?.count else { return }
        if passWordCount < 6 {
            passWordField.text = ""
            passWordField.placeholder = "비밀번호는 최소 6자리입니다."
            passWordField.attributedPlaceholder = NSAttributedString(string: passWordField.placeholder ?? "비밀번호는 최소 6자리입니다." , attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemRed])
            print("오류: 비밀번호는 최소 6자리입니다.")
        }
        
        guard let code = codeField.text else { return }
        if Int(code) == nil {
            codeField.text = ""
            codeField.placeholder = "숫자로만 입력 가능합니다."
            codeField.attributedPlaceholder = NSAttributedString(string: codeField.placeholder ?? "숫자만 입력 가능합니다." , attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemRed])
            print("오류: 숫자만 입력 가능합니다.")
        }
    }
    
    
}

