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
    }



    @IBAction func `continue`(_ sender: UIButton) {
        //print(#function)
        guard let usernameOrEmail = usernameTextField.text, let password = passwordTextField.text else{
            typeError = 0
            print("Hay nil")
            return
        }
        guard loginViewModel.isNotEmpty(usernameOrEmail) else{
            typeError = 1
            print("Debe ingresar un Username o Email")
            self.usernameTextField.animateError()
            return
        }
        guard loginViewModel.isNotTooLong(usernameOrEmail) else{
            typeError = 2
            print ("el username o email debe tener menos de 10 caracteres")
            return
        }
        guard loginViewModel.isNotEmpty(password) else{
            typeError = 3
            print("Debes ingresar una password")
            self.passwordTextField.animateError()
            return
        }
        guard loginViewModel.isNotTooLong(password) else{
            typeError = 4
            print("La password debe tener menos de 10 caracteres")
            return
        }
        guard loginViewModel.isRegistered(usernameOrEmail: usernameOrEmail, password: password) else{
            typeError = 10
            print("Usuario no registrado")
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

