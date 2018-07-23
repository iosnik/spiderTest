//
//  ImageCollectionViewCell.swift
//  SpiderTestApp
//
//  Created by Антон on 19.07.2018.
//  Copyright © 2018 Anton Trofimov. All rights reserved.
//

import UIKit
import ImgurSession

class ImageCollectionViewCell: UICollectionViewCell {
    
    weak var image: IMGGalleryImage!
    
    @IBOutlet var pictureImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
