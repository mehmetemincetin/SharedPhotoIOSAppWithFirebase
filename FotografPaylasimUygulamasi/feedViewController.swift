//
//  feedViewController.swift
//  FotografPaylasimUygulamasi
//
//  Created by EMİN ÇETİN on 17.12.2022.
//

import UIKit
import Firebase
import SDWebImage


class feedViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var emailDizisi = [String]()
    var yorumDizisi = [String]()
    var gorselDizisi = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
       
        
        firebaseVerileriAl()
    }
    
    func firebaseVerileriAl() {
        
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Post").order(by: "Tarih", descending: true).addSnapshotListener { (snapshot,error) in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.emailDizisi.removeAll(keepingCapacity: false)
                    self.yorumDizisi.removeAll(keepingCapacity: false)
                    self.gorselDizisi.removeAll(keepingCapacity: false)
                    
                    
                    
                    
                    for document in snapshot!.documents {
                        let documenId = document.documentID
                        
                        if let gorselUrl = document.get("gorselurl") as? String {
                            self.gorselDizisi.append(gorselUrl)
                        }
                        if let yorum = document.get("Yorum") as? String {
                            self.yorumDizisi.append(yorum)
                        }
                        
                        if let email = document.get("Email") as? String {
                            self.emailDizisi.append(email)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
     
    }
        
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return emailDizisi.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
            cell.emailLabel.text = emailDizisi[indexPath.row]
            cell.yorumText.text = yorumDizisi[indexPath.row]
            cell.postImageView.sd_setImage(with: URL(string: self.gorselDizisi[indexPath.row]))
            return cell
        }
        
    }


