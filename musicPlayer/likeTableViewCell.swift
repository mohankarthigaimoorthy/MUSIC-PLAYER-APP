//
//  likeTableViewCell.swift
//  musicPlayer
//
//  Created by Mohan K on 06/01/23.
//

import UIKit

class likeTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImg: UIImageView!
    
    @IBOutlet weak var theory: UILabel!
    
    
    @IBOutlet weak var company: UILabel!
    
    
    @IBOutlet weak var option: UIButton!
    
    var models = [Model]()
var rest = [restAPI]()
    
//    static let identifier = "likeTableViewCell"
//
//    static func nib() -> UINib {
//        return UINib(nibName: "likeTableViewCell", bundle: nil)
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        newsImg.layer.cornerRadius = 15
        // Configure the view for the selected state
    }

    
    
    
}
