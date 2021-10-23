//
//  InstagramLayout.swift
//  InstagramLayout
//
//  Created by SaiKiran Panuganti on 22/10/21.
//

import UIKit

let screenWidth: CGFloat = UIScreen.main.bounds.width
let screenHeight: CGFloat = UIScreen.main.bounds.height

class InstagramLayout: UICollectionViewFlowLayout {
    let numberOfSections = 0     //Instagram Layout: Will have only 1 section
    var cellWidth: CGFloat = 0
    var cellHeight: CGFloat = 0
    var noOfCellInLine: CGFloat = 3
    let cellSpacing: CGFloat = 5
    let largeItem: CGFloat = 2
    
    var layoutAttributes: [[UICollectionViewLayoutAttributes]] = []
    
    var contentSize: CGSize = .zero
    
    override func prepare() {
        guard let collectionView = collectionView else { return }
        
        if layoutAttributes.count == numberOfSections {
            cellWidth = (collectionView.frame.width - (cellSpacing*(noOfCellInLine + 1)))/noOfCellInLine
            cellHeight = cellWidth
            
            calculateLayoutAttributes(collectionView: collectionView)
            
            print("Calculating frames is done")
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        for section in layoutAttributes {
            let filteredArray = section.filter { obj -> Bool in
                return rect.intersects(obj.frame)
            }
            attributes.append(contentsOf: filteredArray)
        }
        return attributes
    }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    func calculateLayoutAttributes(collectionView: UICollectionView) {
        var sectionAttributes: [UICollectionViewLayoutAttributes] = []
        
        for item in 0..<collectionView.numberOfItems(inSection: numberOfSections) {
            let indexPath = IndexPath(item: item, section: numberOfSections)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let addition = item/9
            
            if (item-6)%9 == 0 {
                let itemSpacing = cellSpacing
                let lineSpacing = cellSpacing*CGFloat((item/3)+1+addition)
                let xOffset = itemSpacing
                let yOffset = (CGFloat((item/3)+addition)*cellHeight) + lineSpacing
                
                attributes.frame = CGRect(x: xOffset, y: yOffset, width: (cellWidth*2)+cellSpacing, height: (cellHeight*2)+cellSpacing)
            }else if (item-7)%9 == 0 {
                let itemSpacing = cellSpacing*3
                let lineSpacing = cellSpacing*CGFloat((item/3)+1+addition)
                let xOffset = (2*cellWidth) + itemSpacing
                let yOffset = (CGFloat((item/3)+addition)*cellHeight) + lineSpacing
                
                attributes.frame = CGRect(x: xOffset, y: yOffset, width: cellWidth, height: cellHeight)
            }else if (item-8)%9 == 0 {
                let itemSpacing = cellSpacing*3
                let lineSpacing = cellSpacing*CGFloat((item/3)+2+addition)
                let xOffset = (2*cellWidth) + itemSpacing
                let yOffset = (CGFloat((item/3)+1+addition)*cellHeight) + lineSpacing
                
                attributes.frame = CGRect(x: xOffset, y: yOffset, width: cellWidth, height: cellHeight)
            }else {
                let itemSpacing = cellSpacing*CGFloat((item%3)+1)
                let lineSpacing = cellSpacing*CGFloat((item/3)+1+addition)
                let xOffset = (CGFloat((item%3))*cellWidth) + itemSpacing
                let yOffset = (CGFloat((item/3)+addition)*cellHeight) + lineSpacing
                
                attributes.frame = CGRect(x: xOffset, y: yOffset, width: cellWidth, height: cellHeight)
            }
            
            sectionAttributes.append(attributes)
        }
        
        layoutAttributes.append(sectionAttributes)
        
        if let attributes = layoutAttributes.last?.last {
            contentSize = CGSize(width: collectionView.frame.width, height: attributes.frame.maxY)
        }
    }
}
