//
//  PinterestFlowLayout.swift
//  CustomCollectionViewLayout
//
//  Created by SaiKiran Panuganti on 23/10/21.
//

import UIKit

class PinterestFlowLayout: UICollectionViewFlowLayout {
    let numberOfSections = 1     //Tinder Layout: Will have only 1 section
    var cellWidth: CGFloat = 0
    let cellSpacing: CGFloat = 10
    var data: [PinterestData] = []
    
    var layoutAttributes: [[UICollectionViewLayoutAttributes]] = []
    
    var contentSize: CGSize = .zero
    
    override func prepare() {
        guard let collectionView = collectionView else { return }
        
        if (layoutAttributes.count == 0) || (layoutAttributes.first?.count != collectionView.numberOfItems(inSection: 0)) {
            data = PinterestSharedData.shared.data
            cellWidth = (collectionView.frame.width - 30)/2
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
        layoutAttributes = []
        
        for section in 0..<collectionView.numberOfSections {
            var sectionAttributes: [UICollectionViewLayoutAttributes] = []
            
            var leftYOffset: CGFloat = 0
            var rightYOffset: CGFloat = 0
            let lineSpacing = cellSpacing
            let itemSpacing = cellSpacing
            
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let itemData = data[item]
                
                var xOffset: CGFloat = 0
                var yOffset: CGFloat = 0
                let cellHeight: CGFloat = cellWidth*(CGFloat(itemData.height)/CGFloat(itemData.width))
                
                if item == 0 {
                    xOffset = itemSpacing
                    yOffset = leftYOffset + lineSpacing
                    leftYOffset = yOffset + cellHeight
                }else if item == 1 {
                    xOffset = cellWidth + (2*itemSpacing)
                    yOffset = rightYOffset + lineSpacing
                    rightYOffset = yOffset + cellHeight
                }else {
                    if (rightYOffset + cellHeight) <= leftYOffset {
                        xOffset = cellWidth + (2*itemSpacing)
                        yOffset = rightYOffset + lineSpacing
                        rightYOffset = yOffset + cellHeight
                    }else if (leftYOffset + cellHeight) <= rightYOffset {
                        xOffset = itemSpacing
                        yOffset = leftYOffset + lineSpacing
                        leftYOffset = yOffset + cellHeight
                    }else {
                        if leftYOffset > rightYOffset {
                            xOffset = cellWidth + (2*itemSpacing)
                            yOffset = rightYOffset + lineSpacing
                            rightYOffset = yOffset + cellHeight
                        }else {
                            xOffset = itemSpacing
                            yOffset = leftYOffset + lineSpacing
                            leftYOffset = yOffset + cellHeight
                        }
                    }
                }
                
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: xOffset, y: yOffset, width: cellWidth, height: cellHeight).integral
                
                sectionAttributes.append(attributes)
            }
            
            layoutAttributes.append(sectionAttributes)
        }
        
        if let attributes = layoutAttributes.last?.last {
            contentSize = CGSize(width: collectionView.frame.width, height: attributes.frame.maxY)
        }
    }
}
