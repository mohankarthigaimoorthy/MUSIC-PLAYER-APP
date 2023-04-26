//
//  segmentTableViewCell.swift
//  musicPlayer
//
//  Created by Mohan K on 23/01/23.
//

import UIKit

class segmentTableViewCell: UITableViewCell {

    @IBOutlet weak var songImage: UIImageView!
    
    
    @IBOutlet weak var label3: UILabel!
    
    
    @IBOutlet weak var tradeMark: UILabel!
    
    @IBOutlet weak var othersBtn: UIButton!
    
    var models = [Model]()
    
    var rest = [restAPI]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        songImage.layer.cornerRadius = 15
//        
        // Configure the view for the selected state
    }

}
