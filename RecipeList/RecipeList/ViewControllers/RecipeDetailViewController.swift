//
//  RecipeDetailViewController.swift
//  RecipeList
//
//  Created by RLSUU210300 on 2022/02/08.
//

import UIKit
import ObjectMapper
import SwiftUI


class RecipeDetailViewController: BaseViewController {
    
    var model: (data: RecipeListMode, isFavor: Bool)?
    
    @IBOutlet private weak var menuImage: UIImageView!
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var favorButton: UIButton!
    
    
    private var isSelected = false
    
    private let viewModel = RecipeDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    private func setupLayout() {
        
        guard let model = model else {
            return
        }
        favorButton.isSelected = model.isFavor
        
        isSelected = model.isFavor
        self.descriptionLabel.text = model.data.thumbnails?.title
        menuImage.kf.indicatorType = .activity
        let imageUrl = URL(string: model.data.thumbnails?.thumbnailLink ?? "")
        self.menuImage.kf.setImage(with: imageUrl, placeholder: nil, options: [.cacheOriginalImage], progressBlock: { receivedSize, totalSize in
            
        },  completionHandler: nil)
        favorButton.rx.tap.subscribe(onNext:{ [self] _ in
            
            isSelected = !isSelected
            favorButton.isSelected = isSelected
            showAlert(isSelected: isSelected, model: model.data)
        }).disposed(by: self.disposeBag)
        
    }
    
    private func showAlert(isSelected: Bool, model: RecipeListMode) {
        
        if isSelected {
            let alertView = UIAlertController(title: "", message: R.string.localizable.recipeDetailAlertMessage(), preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: { UIAlertAction in
                self.viewModel.saveFavoritesPersistently(model: model)
            }))
            self.present(alertView, animated: true, completion: nil)
        } else {
            viewModel.deleteFavoritesPersistently(model: model)
        }
    }
}
