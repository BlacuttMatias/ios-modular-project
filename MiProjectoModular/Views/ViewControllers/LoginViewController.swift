//
//  ViewController.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 25/10/2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    var usernameErrorLabel: UILabel = UILabel()
    var passwordErrorLabel: UILabel = UILabel()
    var invalidLoginView: UILabel = UILabel()
    
    var typeError: Int = 0
    var loginViewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundColorName = Resource.backgroundColor
        let labelColorName = Resource.labelColor
        
        signInLabel.textColor = UIColor(named: labelColorName)
        self.view.backgroundColor = UIColor(named: backgroundColorName)
        
        signInButton.roundedBorder()
        
        self.usernameTextField.setRoundedBorders()
        self.passwordTextField.setRoundedBorders()
        
        self.setUsernameErrorLabel()
        self.setPasswordErrorLabel()

        self.setInvalidLoginView(width: self.passwordTextField.frame.width - 25)
    }

    func setUsernameErrorLabel(){
        self.setErrorLabel(label: usernameErrorLabel, textField: usernameTextField)
    }
    
    func setPasswordErrorLabel(){
        self.setErrorLabel(label: passwordErrorLabel, textField: passwordTextField)
    }
    
    func showUsernameError(errorMessage: String){
        self.showLabelError(label: self.usernameErrorLabel, errorMessage: errorMessage)
    }
    
    func showPasswordError(errorMessage: String){
        self.showLabelError(label: self.passwordErrorLabel, errorMessage: errorMessage)
    }
    
    func setInvalidLoginView(width: CGFloat){
        invalidLoginView.backgroundColor = UIColor(named: Resource.errorBackgroundColor)
        invalidLoginView.text = "Username/Email or password incorrect"
        invalidLoginView.textAlignment = .center
        invalidLoginView.numberOfLines = 0
        invalidLoginView.layer.cornerRadius = 8
        invalidLoginView.layer.masksToBounds = true
        invalidLoginView.layer.borderWidth = 3
        invalidLoginView.layer.borderColor = UIColor.red.cgColor
        invalidLoginView.alpha = 0
        
        self.view.addSubview(self.invalidLoginView)
        
        let constraintSetter = ConstraintsSetter(uiView: self.invalidLoginView)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.passwordTextField.bottomAnchor, distance: 20)
        constraintSetter.setCenterXContraint(referenceAnchorView: self.view.centerXAnchor)
        constraintSetter.setWidthConstraint(width: width)
        constraintSetter.setBottomEqualContraint(referenceAnchorView: self.signInButton.topAnchor, distance: -40)
    }
    
    func showInvalidLogin(){
        UIView.animate(withDuration: 0.7, animations: {
            self.invalidLoginView.alpha = 1
        })
    }
    
    func hideErrors(){
        UIView.animate(withDuration: 0.1, animations: {
            self.usernameErrorLabel.alpha = 0
            self.passwordErrorLabel.alpha = 0
            self.usernameTextField.setDefaultBorderColor()
            self.passwordTextField.setDefaultBorderColor()
            self.invalidLoginView.alpha = 0
        })

    }

    @IBAction func `continue`(_ sender: UIButton) {
        //print(#function)
        self.hideErrors()
        guard let usernameOrEmail = usernameTextField.text, let password = passwordTextField.text else{
            typeError = 0
            print("Hay nil")
            return
        }
        guard loginViewModel.isNotEmpty(usernameOrEmail) else{
            typeError = 1
            self.usernameTextField.animateError()
            self.showUsernameError(errorMessage: "This field is required")
            return
        }
        guard loginViewModel.isNotTooLong(usernameOrEmail) else{
            typeError = 2
            self.usernameTextField.animateError()
            self.showUsernameError(errorMessage: "Username or Email must have least than 10 characters")
            return
        }
        guard loginViewModel.isNotEmpty(password) else{
            typeError = 3
            self.passwordTextField.animateError()
            self.showPasswordError(errorMessage: "This field is required")
            return
        }
        guard loginViewModel.isNotTooLong(password) else{
            typeError = 4
            self.passwordTextField.animateError()
            self.showPasswordError(errorMessage: "Password must have least than 10 characters")
            return
        }
        guard loginViewModel.isRegistered(usernameOrEmail: usernameOrEmail, password: password) else{
            typeError = 10
            self.signInButton.animateError()
            self.showInvalidLogin()
            return
        }
        goToWelcomeViewController()
        //print("Usuario autenticado")
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        print(#function)
    }
    
    func goToWelcomeViewController() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: loginViewModel.getNameWelcomeViewController()) as? TabViewController
      vc!.modalPresentationStyle = .fullScreen
      self.present(vc!, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
       AppUtility.lockOrientation(.portrait)
       // Or to rotate and lock
       // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
       
   }
    
}

