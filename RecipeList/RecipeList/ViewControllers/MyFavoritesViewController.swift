//
//  MyFavoritesViewController.swift
//  RecipeList
//
//  Created by RLSUU210300 on 2022/02/06.
//

import UIKit
import RxSwift
import RxDataSources

class MyFavoritesViewController: BaseViewController {
    
    private struct LayoutConstantValue {
        static let anchorCellMargin = CGFloat(12.0)
        static let textLabelHeight = CGFloat(40)
        static let imageToLabelSpace = CGFloat(8)
        static let countOfRow = Int(2)
    }
    
    lazy var layout: UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = LayoutConstantValue.anchorCellMargin
        layout.minimumLineSpacing = LayoutConstantValue.anchorCellMargin
        layout.scrollDirection = .vertical
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: LayoutConstantValue.anchorCellMargin, bottom: LayoutConstantValue.anchorCellMargin, right: LayoutConstantValue.anchorCellMargin)
        return layout
    }()
    
    private var viewModel: MyFavoritesViewModel = MyFavoritesViewModel()
    
    @IBOutlet weak var headLabel: UILabel!
    
    @IBOutlet weak var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = R.string.localizable.myFavoritesNavBarTitle()
        viewModel.getData()
        headLabel.text = "お気に入り件数　\(viewModel.data.value.count)"
    }
    
    func setupCollectionView() {
        
        collectionview.setCollectionViewLayout(layout, animated: true)
        collectionview.register(R.nib.recipeListCollectionViewCell)
        
        viewModel.data.bind(to: collectionview.rx.items) {(collectionview, row, element) in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "RecipeListCollectionViewCell", for: indexPath) as! RecipeListCollectionViewCell
            
            cell.setModelWithoutFavor(model: element)
            return cell
        }.disposed(by: disposeBag)
        
        collectionview.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

extension MyFavoritesViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let imageLength = (UIScreen.main.bounds.size.width - 3.0 * LayoutConstantValue.anchorCellMargin) / CGFloat(LayoutConstantValue.countOfRow)
        
        return CGSize(width: imageLength, height: imageLength + LayoutConstantValue.textLabelHeight + LayoutConstantValue.imageToLabelSpace)
    }
}
