//
//  PinterestViewController.swift
//  CustomCollectionViewLayout
//
//  Created by SaiKiran Panuganti on 23/10/21.
//

import UIKit
import SDWebImage

class PinterestViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pinterestData: [PinterestData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        getData()
        addBackgroundGradient()
    }
    
    private func addBackgroundGradient() {
        let collectionViewBackgroundView = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = view.frame.size
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.colors = [#colorLiteral(red: 1, green: 1, blue: 0, alpha: 1).cgColor, #colorLiteral(red: 0.6196078431, green: 0.7582198267, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.5, green: 0.6205467145, blue: 1, alpha: 1).cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        collectionView.backgroundView = collectionViewBackgroundView
        collectionView.backgroundView?.layer.addSublayer(gradientLayer)
      }
    
    func getData() {
        NetworkAdaptor.request(url: "https://aug5ejbir3.execute-api.ap-south-1.amazonaws.com/dev/pinterest", method: .get) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(PinterestModel.self, from: data)
                    self.pinterestData = decodedData.body ?? []
                    PinterestSharedData.shared.data = decodedData.body ?? []
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension PinterestViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pinterestData.count //(pinterestData.count != 0) ? 2 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell {
            if let url = URL(string: pinterestData[indexPath.row].imgURL) {
                cell.cellImage.sd_setImage(with: url, completed: nil)
                cell.cellImage.layer.cornerRadius = 10
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension PinterestViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(pinterestData[indexPath.row])
    }
}
