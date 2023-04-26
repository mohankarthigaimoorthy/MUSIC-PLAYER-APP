//
//  newsInfoTableViewCell.swift
//  musicPlayer
//
//  Created by Mohan K on 05/01/23.
//

import UIKit

class newsInfoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var newsimage: UIImageView!
    
    
    @IBOutlet weak var news: UILabel!
    
    
    @IBOutlet weak var televisionChannel: UILabel!
    
    
    @IBOutlet weak var more: UIButton!
    
    var rest = [restAPI]()
    
    var models = [Model]()
    
    static let identifier = "newsInfoTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "newsInfoTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        newsimage.layer.cornerRadius = 15
    }

}
