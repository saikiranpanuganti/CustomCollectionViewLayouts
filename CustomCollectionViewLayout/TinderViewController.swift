//
//  TinderViewController.swift
//  CustomCollectionViewLayout
//
//  Created by SaiKiran Panuganti on 22/10/21.
//

import UIKit

class TinderViewController: UIViewController {
    var stackContainer : TinderContainerView!
    
    var stackData: [StackData] = [StackData(color: UIColor.systemRed), StackData(color: UIColor.systemBlue), StackData(color: UIColor.systemYellow), StackData(color: UIColor.systemGreen), StackData(color: UIColor.darkGray), StackData(color: UIColor.brown)]
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        stackContainer = TinderContainerView()
        view.addSubview(stackContainer)
        configureStackContainer()
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        configureNavigationBarButtonItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Tinder"
        stackContainer.dataSource = self
    }

    func configureStackContainer() {
        stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        stackContainer.widthAnchor.constraint(equalToConstant: 300).isActive = true
        stackContainer.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    func configureNavigationBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetTapped))
    }
    
    //MARK: - Handlers
    @objc func resetTapped() {
        stackContainer.reloadData()
    }
}

extension TinderViewController: TinderContainerViewDataSource {
    var data: [TinderCardViewDataSource] {
        return stackData
    }
}


class StackData {
    var color: UIColor
    
    init(color: UIColor) {
        self.color = color
    }
}

extension StackData: TinderCardViewDataSource {
    var backGroundColor: UIColor {
        return color
    }
}
