//
//  songCollectionViewCell.swift
//  musicPlayer
//
//  Created by Mohan K on 06/01/23.
//

import UIKit

class songCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var musicPlayInfo: UIImageView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    static let identifier = "songCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "songCollectionViewCell", bundle: nil)
    }
    
    var songs = [Model]()
    
    var rest = [restAPI]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        musicPlayInfo.layer.cornerRadius = 15
    }

}
