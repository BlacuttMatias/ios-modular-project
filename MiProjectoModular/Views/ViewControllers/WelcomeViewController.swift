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
    private var welcomeViewModel: WelcomeViewModel = WelcomeViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imagenLogo.image = UIImage(named: Resource.welcomeImage)
        logoutButton.roundedBorder()
        self.addGestures()
    }
    
    private func addGestures(){
        self.imagenLogo.isUserInteractionEnabled = true

        let tapImageLogoGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImageLogo(_:)))
        let pinchImageGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinchImageLogo(_:)))
        
        self.imagenLogo.addGestureRecognizer(tapImageLogoGesture)
        self.imagenLogo.addGestureRecognizer(pinchImageGesture)
    }
    
    @objc func didPinchImageLogo(_ sender: UIPinchGestureRecognizer){
        if let scale = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)){
            guard scale.a > 1.0 && scale.a < 2.0 else{
                return
            }
            guard scale.d > 1.0 && scale.d < 2.0 else{
                return
            }
            
            sender.view?.transform = scale
            sender.scale = 1
        }
    }
    
    @objc func didTapImageLogo(_ sender: UITapGestureRecognizer){
        self.showSimpleAlert(title: self.welcomeViewModel.getAppInfoAlertTitle(), message: self.welcomeViewModel.getAppInfoAlertMessage())
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
