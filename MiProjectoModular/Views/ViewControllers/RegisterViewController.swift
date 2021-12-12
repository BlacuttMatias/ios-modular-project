//
//  RegisterViewController.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 27/10/2021.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpFacebbokButton: UIButton!
    var usernameErrorLabel: UILabel = UILabel()
    var emailErrorLabel: UILabel = UILabel()
    var passwordErrorLabel: UILabel = UILabel()
    var typeError: Int = 0
    var registerViewModel: RegisterViewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.roundedBorder()
        signUpFacebbokButton.roundedBorder()
        
        usernameTextField.setErrorStyle()
        emailTextField.setErrorStyle()
        passwordTextField.setErrorStyle()
        
        self.setUsernameErrorLabel()
        self.setEmailErrorLabel()
        self.setPasswordErrorLabel()
        
    }
    
    func setUsernameErrorLabel(){
        self.setErrorLabel(label: usernameErrorLabel, textField: usernameTextField)
    }
    
    func setEmailErrorLabel(){
        self.setErrorLabel(label: emailErrorLabel, textField: emailTextField)
    }
    
    func setPasswordErrorLabel(){
        self.setErrorLabel(label: passwordErrorLabel, textField: passwordTextField)
    }
    
    func showUsernameError(errorMessage: String){
        self.showLabelError(label: self.usernameErrorLabel, errorMessage: errorMessage)
    }
    
    func showEmailError(errorMessage: String){
        self.showLabelError(label: self.emailErrorLabel, errorMessage: errorMessage)
    }
    
    func showPasswordError(errorMessage: String){
        self.showLabelError(label: self.passwordErrorLabel, errorMessage: errorMessage)
    }
    
    func hideErrors(){
        UIView.animate(withDuration: 0.1, animations: {
            self.usernameErrorLabel.alpha = 0
            self.emailErrorLabel.alpha = 0
            self.passwordErrorLabel.alpha = 0
            self.usernameTextField.hideErrorStyle()
            self.emailTextField.hideErrorStyle()
            self.passwordTextField.hideErrorStyle()
        })

    }
    
    @IBAction func signIn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func register(_ sender: UIButton) {
        self.hideErrors()
        guard let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else{
            typeError = 0
            print("Hay nil")
            return
        }
        guard registerViewModel.isNotEmpty(username) else{
            typeError = 5
            self.usernameTextField.animateError()
            self.showUsernameError(errorMessage: "This field is required")
            return
        }
        guard registerViewModel.isNotTooLong(username) else{
            typeError = 6
            self.usernameTextField.animateError()
            self.showUsernameError(errorMessage: "Username must have least than 10 characters")
            return
        }
        guard registerViewModel.isNotEmpty(email) else{
            typeError = 1
            self.emailTextField.animateError()
            self.showEmailError(errorMessage: "This field is required")
            return
        }
        guard registerViewModel.isValidEmail(email) else{
            typeError = 2
            self.emailTextField.animateError()
            self.showEmailError(errorMessage: "Email must have \"@\" and least than 10 characters")
            return
        }
        guard registerViewModel.isNotEmpty(password) else{
            typeError = 3
            self.passwordTextField.animateError()
            self.showPasswordError(errorMessage: "This field is required")
            return
        }
        guard registerViewModel.isNotTooLong(password) else{
            typeError = 4
            self.passwordTextField.animateError()
            self.showPasswordError(errorMessage: "Password must have least than 10 characters")
            return
        }
        goToWelcomeViewController()
        //print("Usuario registrado")
        
    }
    
    func goToWelcomeViewController() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: registerViewModel.getNameWelcomeViewController()) as? TabViewController
      vc!.modalPresentationStyle = .fullScreen
      self.present(vc!, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    }
