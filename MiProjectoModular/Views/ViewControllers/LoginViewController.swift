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
    var invalidLoginView: UIViewError = UIViewError()
    var loginViewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginViewModel.setLoginDelegate(loginDelegate: self)
        
        let backgroundColorName = Resource.backgroundColor
        let labelColorName = Resource.labelColor
        
        signInLabel.textColor = UIColor(named: labelColorName)
        self.view.backgroundColor = UIColor(named: backgroundColorName)
        
        signInButton.roundedBorder()
        
        self.usernameTextField.setErrorStyle()
        self.passwordTextField.setErrorStyle()
        
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
    
    func setInvalidLoginView(width: CGFloat){

        self.view.addSubview(self.invalidLoginView)
        
        let constraintSetter = ConstraintsSetter(uiView: self.invalidLoginView)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.passwordTextField.bottomAnchor, distance: 20)
        constraintSetter.setCenterXContraint(referenceAnchorView: self.view.centerXAnchor)
        constraintSetter.setWidthConstraint(width: width)
        constraintSetter.setBottomEqualContraint(referenceAnchorView: self.signInButton.topAnchor, distance: -40)
    }
    
    func showInvalidLogin(errorMessage: String){
        self.invalidLoginView.setErrorMessage(errorMessage: errorMessage)
        UIView.animate(withDuration: 0.7, animations: {
            self.invalidLoginView.alpha = 1
        })
    }
    
    func hideErrors(){
        UIView.animate(withDuration: 0.1, animations: {
            self.usernameErrorLabel.alpha = 0
            self.passwordErrorLabel.alpha = 0
            self.usernameTextField.hideErrorStyle()
            self.passwordTextField.hideErrorStyle()
            self.invalidLoginView.alpha = 0
        })

    }

    @IBAction func `continue`(_ sender: UIButton) {
        //print(#function)
        self.hideErrors()
        let usernameOrEmail = usernameTextField.text
        let password = passwordTextField.text
        self.loginViewModel.login(optionalUsernameOrEmail: usernameOrEmail, optionalPassword: password)
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

extension LoginViewController: LoginDelegate{

    func showUsernameEmailError(errorMessage: String) {
        self.usernameTextField.animateError()
        self.showLabelError(label: self.usernameErrorLabel, errorMessage: errorMessage)
    }
    
    func showPasswordError(errorMessage: String){
        self.passwordTextField.animateError()
        self.showLabelError(label: self.passwordErrorLabel, errorMessage: errorMessage)
    }
    
    func showLoginUserError(errorMessage: String) {
        self.signInButton.animateError()
        self.showInvalidLogin(errorMessage: errorMessage)
    }
    
    func succesfulLogin() {
        goToWelcomeViewController()
    }
    
}
