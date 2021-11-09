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
    var typeError: Int = 0
    var registerValidator: RegisterValidator = RegisterValidator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.layer.cornerRadius = 10.0
        signUpFacebbokButton.layer.cornerRadius = 10.0
    }
    
    
    @IBAction func signIn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func register(_ sender: UIButton) {
        guard let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else{
            typeError = 0
            print("Hay nil")
            return
        }
        guard registerValidator.isNotEmpty(username) else{
            typeError = 5
            print("Debes ingresar un Username")
            return
        }
        guard registerValidator.isNotTooLong(username) else{
            typeError = 6
            print ("El username debe tener menos de 10 caracteres")
            return
        }
        guard registerValidator.isNotEmpty(email) else{
            typeError = 1
            print ("Debes ingresar un Email")
            return
        }
        guard registerValidator.isValidEmail(email) else{
            typeError = 2
            print("El email debe tener @ y menos de 10 caracteres")
            return
        }
        guard registerValidator.isNotEmpty(password) else{
            typeError = 3
            print("Debes ingresar una password")
            return
        }
        guard registerValidator.isNotTooLong(password) else{
            typeError = 4
            print("La password debe tener menos de 10 caracteres")
            return
        }
        goToWelcomeViewController()
        //print("Usuario registrado")
        
    }
    
    func goToWelcomeViewController() {
      let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabViewController") as? TabViewController
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
