//
//  cell2CollectionViewCell.swift
//  musicPlayer
//
//  Created by Mohan K on 05/01/23.
//

import UIKit
import MarqueeLabel

class cell2CollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imageInfo: UIImageView!
    
    @IBOutlet weak var trackname: MarqueeLabel!
    
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var timing: UILabel!
    
    static let identifier = "cell2CollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "cell2CollectionViewCell", bundle: nil)
    }
    
    var models = [Model]()
    override func awakeFromNib() {
        super.awakeFromNib()
        imageInfo.layer.cornerRadius = 30
        
        
        trackname.speed = .duration(10)
        trackname.animationCurve = .easeInOut
        trackname.fadeLength = 10.0
        trackname.leadingBuffer = 30.0
      
    }

    
    
    
    @IBAction func didClick(_ sender: Any) {
        
        
    }
    
}
