//
//  WelcomeViewController.swift
//  LocationDemoApp
//
//  Created by Dardan Xërxa on 6/2/21.
//  Copyright © 2021 Dardan Xërxa. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          navigationController?.isNavigationBarHidden = true
      }
      
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }

    @IBAction func signInPressed(_ sender: UIButton) {
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
    }
}

