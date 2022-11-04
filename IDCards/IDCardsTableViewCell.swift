//
//  IDCardsTableViewCell.swift
//  IDCards
//
//  Created by Shraddha Manwar on 02/07/22.
//

import UIKit

class IDCardsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileStudent: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
