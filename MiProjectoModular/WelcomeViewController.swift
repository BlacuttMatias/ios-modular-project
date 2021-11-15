//
//  WelcomeViewController.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 29/10/2021.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var imagenLogo: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagenLogo.image = UIImage(named: Resource.welcomeImage)
        logoutButton.layer.cornerRadius = 10.0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Logout(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        //navigationController?.popViewController(animated: true)
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
