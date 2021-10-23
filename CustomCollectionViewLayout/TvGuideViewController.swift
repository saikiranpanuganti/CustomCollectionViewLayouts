//
//  TvGuideViewController.swift
//  CustomCollectionViewLayout
//
//  Created by SaiKiran Panuganti on 22/10/21.
//

import UIKit

class TvGuideViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "TvGuideCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TvGuideCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension TvGuideViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TvGuideCollectionViewCell", for: indexPath) as? TvGuideCollectionViewCell {
            cell.cellLabel.text = "Program S\(indexPath.section) R\(indexPath.row)"
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 2.0
            return cell
        }
        return UICollectionViewCell()
    }
}

extension TvGuideViewController: UICollectionViewDelegate {
    
}
