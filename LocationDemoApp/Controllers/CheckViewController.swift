//
//  CheckViewController.swift
//  LocationDemoApp
//
//  Created by Dardan Xërxa on 2.6.21.
//  Copyright © 2021 Dardan Xërxa. All rights reserved.
//

import UIKit
import Firebase

class CheckViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:
                        Auth.auth().currentUser == nil ? "welcomeNav" : "locationNav")
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
}
