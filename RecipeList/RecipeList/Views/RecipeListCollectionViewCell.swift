//
//  RecipeListCollectionViewCell.swift
//  RecipeList
//
//  Created by RLSUU210300 on 2022/02/06.
//

import UIKit
import Kingfisher

class RecipeListCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var describeLabel: UILabel!
    
    @IBOutlet weak var thumbnail: UIImageView!
    
    @IBOutlet weak var favorImage: UIImageView!
    
    func setModelWithFavor(model: (data: RecipeListMode, isFavor: Bool)) {
        describeLabel.text = model.data.thumbnails?.title
        
        let imageUrl = URL(string: model.data.thumbnails?.thumbnailLink ?? "")
        thumbnail.kf.indicatorType = .activity
        self.thumbnail.kf.setImage(with: imageUrl, placeholder: nil, options: [.cacheOriginalImage], progressBlock: { receivedSize, totalSize in
            
        }, completionHandler: nil)
        
        self.favorImage.isHidden = false
        if model.isFavor {
            self.favorImage.image = R.image.btnFavoriteSelected()
        } else {
            self.favorImage.image = R.image.btnFavoriteNormal()
        }
    }
    
    func setModelWithoutFavor(model: RecipeListMode) {
        setModelWithFavor(model: (model, false))
        self.favorImage.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        describeLabel.sizeToFit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
