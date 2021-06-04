//
//  SignInViewController.swift
//  LocationDemoApp
//
//  Created by Dardan Xërxa on 6/2/21.
//  Copyright © 2021 Dardan Xërxa. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "locationNav")
        vc.modalPresentationStyle = .fullScreen
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error == nil {
                    self.present(vc, animated: false)
                }
            }
        }
    }
}
