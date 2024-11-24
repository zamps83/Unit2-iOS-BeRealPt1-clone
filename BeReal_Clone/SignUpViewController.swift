import ParseSwift

struct User: ParseUser {
    var objectId: String?
    var username: String?
    var password: String?
    var email: String?
    var emailVerified: Bool?
    var authData: [String: [String: String]?]?
}

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func onSignUpTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        
        var newUser = User()
        newUser.username = username
        newUser.email = email
        newUser.password = password
        
        newUser.signup { result in
            switch result {
            case .success(let user):
                print("✅ Successfully signed up user \(user)")
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
            case .failure(let error):
                self.showAlert(description: error.localizedDescription)
            }
        }
    }
    
    func showAlert(description: String) {
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
