//
//  FeedCell.swift
//  FotografPaylasimUygulamasi
//
//  Created by EMİN ÇETİN on 18.12.2022.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var yorumText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
