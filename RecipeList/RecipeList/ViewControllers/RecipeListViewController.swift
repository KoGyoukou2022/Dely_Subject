//
//  RecipeListViewController.swift
//  RecipeList
//
//  Created by RLSUU210300 on 2022/02/05.
//

import UIKit


class RecipeListViewController: BaseViewController {
    
    private struct LayoutConstantValue {
        static let anchorCellMargin = CGFloat(12.0)
        static let textLabelHeight = CGFloat(40)
        static let imageToLabelSpace = CGFloat(8)
        static let countOfRow = Int(2)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel = RecipeListViewModel()
    
    lazy var layout: UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = LayoutConstantValue.anchorCellMargin
        layout.minimumLineSpacing = LayoutConstantValue.anchorCellMargin
        layout.scrollDirection = .vertical
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: LayoutConstantValue.anchorCellMargin, bottom: LayoutConstantValue.anchorCellMargin, right: LayoutConstantValue.anchorCellMargin)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = R.string.localizable.recipeListNavBarTitle()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadRecipeListDatawithMapObject()
    }
    
    func setupCollectionView() {
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(R.nib.recipeListCollectionViewCell)
        
        viewModel.dataWithfavor.bind(to: collectionView.rx.items) {(collectionView, row, element) in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeListCollectionViewCell", for: indexPath) as! RecipeListCollectionViewCell
            
            cell.setModelWithFavor(model: element)
            return cell
        }
        .disposed(by: disposeBag)
        
        collectionView.rx
            .modelSelected((RecipeListMode, Bool).self)
            .subscribe(onNext:{ model in
                let vc = R.storyboard.recipeDetailViewController.instantiateInitialViewController()!
                vc.model = model
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: self.disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

extension RecipeListViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let imageLength = (UIScreen.main.bounds.size.width - 3.0 * LayoutConstantValue.anchorCellMargin) / CGFloat(LayoutConstantValue.countOfRow)
        
        return CGSize(width: imageLength, height: imageLength + LayoutConstantValue.textLabelHeight + LayoutConstantValue.imageToLabelSpace)
    }
}

