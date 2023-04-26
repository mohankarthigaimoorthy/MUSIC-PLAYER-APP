//
//  cell1CollectionViewCell.swift
//  musicPlayer
//
//  Created by Mohan K on 05/01/23.
//

import UIKit

class cell1CollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var song: UILabel!
    
    static let identifier = "cell1CollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "cell1CollectionViewCell", bundle: nil)
    }
    
    var models = [Model]()
    
    override var isSelected: Bool{
        didSet{
            song.backgroundColor = isSelected ? .white : .clear

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
