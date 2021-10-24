//
//  MagicalGridViewController.swift
//  CustomCollectionViewLayout
//
//  Created by SaiKiran Panuganti on 23/10/21.
//

import UIKit

class MagicalGridViewController: UIViewController {
    @IBOutlet weak var topView: UIView!
    
    let numberOfColumns: Int = 15
    var cellWidth: CGFloat = 0
    var numberOfRows: Int = 0
    var cells: [String: UIView] = [:]
    var selectedCellView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellWidth = topView.frame.width/CGFloat(numberOfColumns)
        numberOfRows = Int(topView.frame.height/cellWidth)
        
        for j in 0..<numberOfRows {
            for i in 0..<numberOfColumns {
                let cellView = UIView()
                cellView.backgroundColor = generateRandomColor()
                cellView.frame = CGRect(x: CGFloat(i)*cellWidth, y: CGFloat(j)*cellWidth, width: cellWidth, height: cellWidth)
                cellView.layer.borderWidth = 0.5
                cellView.layer.borderColor = UIColor.black.cgColor
                
                let key = "\(i)|\(j)"
                cells[key] = cellView
                topView.addSubview(cellView)
            }
        }
        
        topView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:))))
    }
    
    func generateRandomColor() -> UIColor{
        let randomR = CGFloat.random(in: 0...255)
        let randomG = CGFloat.random(in: 0...255)
        let randomB = CGFloat.random(in: 0...255)
        return UIColor(red: randomR/255, green: randomG/255, blue: randomB/255, alpha: 1)
    }

    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: topView)
        
        let x = Int(location.x/cellWidth)
        let y = Int(location.y/cellWidth)
        
        let key = "\(x)|\(y)"
        guard let cellView = cells[key] else { return }
        
        if selectedCellView != cellView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
                self.selectedCellView?.layer.transform = CATransform3DIdentity
            } completion: { bool in
                
            }
        }

        selectedCellView = cellView
        
        topView.bringSubviewToFront(cellView)
        
//        self.cellView.superview?.bringSubview(toFront: self.cellView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        } completion: { bool in
            
        }

    }
}

