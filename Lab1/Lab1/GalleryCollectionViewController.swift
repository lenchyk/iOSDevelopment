//
//  GalleryCollectionViewController.swift
//  Lab1
//
//  Created by Anna Berezhniak on 03.12.2020.
//  Copyright © 2020 Anna Berezhniak. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class GalleryCollectionViewController: UICollectionViewController {
    
    @IBOutlet var galleryCollectionView: UICollectionView!{
        didSet{
            galleryCollectionView.delegate = self
            galleryCollectionView.dataSource = self
            
            galleryCollectionView.collectionViewLayout = GalleryCollectionViewController.createLayout()
        }
    }
    
    var imageArray = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonAdd = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addPhoto))
        buttonAdd.setTitleTextAttributes([
                                            NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 35)!], for: .normal)
        self.navigationItem.rightBarButtonItem = buttonAdd
        

    }

    @objc func addPhoto() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    // function for creating custom layout
    static func createLayout() -> UICollectionViewCompositionalLayout {
            // Items
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(3/4)))
            
            let verticalStackItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
            let VerticalStackGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/5), heightDimension: .fractionalHeight(1)), subitem: verticalStackItem, count: 2)
            
            let tripleItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(5/9)))
            
            let tripleHorizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/4)), subitem: tripleItem, count: 3)
            // groups
            let horizontalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(3/5), heightDimension: .fractionalWidth(1)),subitems: [item, tripleHorizontalGroup])
                    
            let mainGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)),subitems: [horizontalGroup, VerticalStackGroup])
            
            let section = NSCollectionLayoutSection(group: mainGroup)
        
            return UICollectionViewCompositionalLayout(section: section)
        }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.imageView.image = imageArray[indexPath.row]
        return cell
    }
    
    // function for handling orientation change (doesn't work)
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard previousTraitCollection != nil else { return }
        galleryCollectionView.collectionViewLayout.invalidateLayout()
    }
}

@available(iOS 13.0, *)
extension GalleryCollectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageArray.append(image)
            galleryCollectionView.reloadData()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


