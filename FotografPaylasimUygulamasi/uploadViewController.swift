//
//  uploadViewController.swift
//  FotografPaylasimUygulamasi
//
//  Created by EMİN ÇETİN on 17.12.2022.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

class uploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var gorseImageView: UIImageView!
    
    @IBOutlet weak var yorumTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gorseImageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselsec))
        gorseImageView.addGestureRecognizer(imageGestureRecognizer)
        
    }
    
    @objc func gorselsec() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    func imagePickerController( _ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        gorseImageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated:true , completion:nil)
    }
    
    
    @IBAction func uploadButton(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("Media")
        
        if let data = gorseImageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\( uuid).jpg")
            
            imageReference.putData(data, metadata: nil) { (storagemetadata, error) in
                if error != nil {
                    self.hataMesajiGoster(title: "HATA!", message: error?.localizedDescription ?? "HATA ALDINIZ TEKRAR DENEYİNİZ!")
                }else {
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                           
                            let firestoreDatabase = Firestore.firestore()
                            let firestorePost = ["gorselurl":imageUrl,"Yorum":self.yorumTextField.text!,"Email":Auth.auth().currentUser?.email,"Tarih":FieldValue.serverTimestamp(),"Sifre":Auth.auth().currentUser?.phoneNumber] as[String: Any]
                            firestoreDatabase.collection("Post").addDocument(data: firestorePost) { (error) in
                                if error != nil {
                                    self.hataMesajiGoster(title: "Hata!", message: error?.localizedDescription ?? "Hata Aldınız ,Lütfen Tekrar Deneyiniz!")
                                } else {
                                    self.gorseImageView.image = UIImage(named: "gorsel")
                                    self.yorumTextField.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                                
                            }
                        }
                    }
                    
                }
            }
            
        }
    }
    func hataMesajiGoster(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated: true,completion: nil)
        
        
    }
    
}
