//
//  ViewController.swift
//  FotografPaylasimUygulamasi
//
//  Created by EMİN ÇETİN on 16.12.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var sifreTextField: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }

    @IBAction func girisButton(_ sender: Any) {
        
        if mailTextField.text != "" && sifreTextField.text != "" {
            Auth.auth().signIn(withEmail: mailTextField.text! , password: sifreTextField.text! ) { (authdataresult, error) in
                if error != nil {
                    self.hataMesaji(titleInput: "Hata", messageInput:error?.localizedDescription ?? "Hata,Lütfen Tekrar Deneyiniz." )
                } else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }
        
        
    }
    
    
    @IBAction func kayitButton(_ sender: Any) {
       
        if mailTextField.text != "" && sifreTextField.text != ""{
            // Kayıt Olma İşlemi
            Auth.auth().createUser(withEmail: mailTextField.text!, password: sifreTextField.text!) {
                (AuthDataResult,error) in
                if error != nil{
                    self.hataMesaji(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata Aldınız,Tekrar Deneyiniz")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            //Hata Mesajı
            hataMesaji(titleInput: "Hata", messageInput: "Email ve Parola Giriniz")
        }

        
    }
    
    func hataMesaji(titleInput : String , messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
        alert.addAction(okButton)
        self.present(alert, animated:true , completion:nil)
            }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           
}

