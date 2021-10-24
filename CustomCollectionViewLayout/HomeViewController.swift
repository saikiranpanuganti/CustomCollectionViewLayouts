//
//  HomeViewController.swift
//  CustomCollectionViewLayout
//
//  Created by SaiKiran Panuganti on 22/10/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tvGuideTapped() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TvGuideViewController")
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func instagramTapped() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstagramViewController")
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func tinderTapped() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TinderViewController")
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func pinterestTapped() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PinterestViewController")
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func magicalGridTapped() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MagicalGridViewController")
        navigationController?.pushViewController(controller, animated: true)
    }
}
