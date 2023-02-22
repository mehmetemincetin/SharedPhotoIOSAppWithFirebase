//
//  settingsViewController.swift
//  FotografPaylasimUygulamasi
//
//  Created by EMİN ÇETİN on 17.12.2022.
//

import UIKit
import Firebase

class settingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

   
    @IBAction func cikisButton(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        } catch {
            print("Hata")
        }
        
    }
    
   
}
