//
//  TvGuideFlowLayout.swift
//  TvGuideFlowLayout
//
//  Created by SaiKiran Panuganti on 22/10/21.
//

import UIKit

class TvGuideFlowLayout: UICollectionViewFlowLayout {
    fileprivate let cellSpacing: CGFloat = 0
    fileprivate let cellHeight: CGFloat = 50
    fileprivate let cellWidth: CGFloat = 150
    
    fileprivate var layoutAttributes: [[UICollectionViewLayoutAttributes]] = []
    
    var contentSize: CGSize = .zero
    
    
    override func prepare() {
        guard layoutAttributes.isEmpty == true, let collectionView = collectionView  else { return }
        
        if layoutAttributes.count != collectionView.numberOfSections {
            calculateLayoutAttributes(collectionView: collectionView)
            
            print("Calculating frames is done")
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath.section][indexPath.row]
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
        for section in 0..<collectionView.numberOfSections {
            var sectionAttributes: [UICollectionViewLayoutAttributes] = []
            
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let xOffset = (cellWidth*CGFloat(item)) + (cellSpacing*CGFloat(item+1))
                let yOffset = (cellHeight*CGFloat(section)) + (cellSpacing*CGFloat(section+1))
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: xOffset, y: yOffset, width: cellWidth, height: cellHeight).integral
                
                sectionAttributes.append(attributes)
            }
            
            layoutAttributes.append(sectionAttributes)
        }
        
        if let attributes = layoutAttributes.last?.last {
            contentSize = CGSize(width: attributes.frame.maxX, height: attributes.frame.maxY)
        }
    }
}
