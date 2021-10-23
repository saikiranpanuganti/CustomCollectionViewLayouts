//
//  InstagramViewController.swift
//  CustomCollectionViewLayout
//
//  Created by SaiKiran Panuganti on 22/10/21.
//

import UIKit

class InstagramViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}


extension InstagramViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath)
        return cell
    }
}

extension InstagramViewController: UICollectionViewDelegate {
    
}
