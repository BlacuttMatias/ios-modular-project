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
    var invalidRegisterView: UIViewError = UIViewError()
    var registerViewModel: RegisterViewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerViewModel.setRegisterDelegate(registerDelegate: self)
        
        signUpButton.roundedBorder()
        signUpFacebbokButton.roundedBorder()
        
        usernameTextField.setErrorStyle()
        emailTextField.setErrorStyle()
        passwordTextField.setErrorStyle()
        
        self.setUsernameErrorLabel()
        self.setEmailErrorLabel()
        self.setPasswordErrorLabel()
        
        self.setInvalidRegisterView(width: self.passwordTextField.frame.width - 25)
        
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
    
    func hideErrors(){
        UIView.animate(withDuration: 0.1, animations: {
            self.usernameErrorLabel.alpha = 0
            self.emailErrorLabel.alpha = 0
            self.passwordErrorLabel.alpha = 0
            self.usernameTextField.hideErrorStyle()
            self.emailTextField.hideErrorStyle()
            self.passwordTextField.hideErrorStyle()
            self.invalidRegisterView.alpha = 0
        })

    }
    
    func setInvalidRegisterView(width: CGFloat){

        self.view.addSubview(self.invalidRegisterView)
        
        let constraintSetter = ConstraintsSetter(uiView: self.invalidRegisterView)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.passwordTextField.bottomAnchor, distance: 15)
        constraintSetter.setCenterXContraint(referenceAnchorView: self.view.centerXAnchor)
        constraintSetter.setWidthConstraint(width: width)
        constraintSetter.setBottomEqualContraint(referenceAnchorView: self.signUpButton.topAnchor, distance: -15)
    }
    
    func showInvalidRegister(){
        UIView.animate(withDuration: 0.7, animations: {
            self.invalidRegisterView.alpha = 1
        })
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func register(_ sender: UIButton) {
        self.hideErrors()
        let username = usernameTextField.text
        let email = emailTextField.text
        let password = self.passwordTextField.text
        self.registerViewModel.register(optionalUsername: username, optionalEmail: email, optionalPassword: password)
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

extension RegisterViewController: RegisterDelegate{
    
    func showUsernameError(errorMessage: String){
        self.usernameTextField.animateError()
        self.showLabelError(label: self.usernameErrorLabel, errorMessage: errorMessage)
    }
    
    func showEmailError(errorMessage: String){
        self.emailTextField.animateError()
        self.showLabelError(label: self.emailErrorLabel, errorMessage: errorMessage)
    }
    
    func showPasswordError(errorMessage: String){
        self.passwordTextField.animateError()
        self.showLabelError(label: self.passwordErrorLabel, errorMessage: errorMessage)
    }
    
    func showRegisterUserError(errorMessage: String) {
        self.invalidRegisterView.setErrorMessage(errorMessage: errorMessage)
        self.signUpButton.animateError()
        self.showInvalidRegister()
    }
    
    func succesfulRegister() {
        goToWelcomeViewController()
    }
    
}
