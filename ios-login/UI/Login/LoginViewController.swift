import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: Button!
    
    @IBOutlet weak var usernameTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    
    let viewModel: LoginViewModel! = LoginViewModel(loginService: LoginService())

    @IBAction func signinButtonTapped() {
        defer { viewModel.login() }
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    private func setupTextFields() {
        let textFields: [UITextField] = [usernameTextField, passwordTextField]
        textFields.forEach { textField in
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @objc private func textFieldDidChange(_ textField: TextField) {
        switch textField {
        case usernameTextField:
            viewModel.username.accept(textField.text ?? "")
        case passwordTextField:
            viewModel.password.accept(textField.text ?? "")
        default:
            return
        }
    }
}
