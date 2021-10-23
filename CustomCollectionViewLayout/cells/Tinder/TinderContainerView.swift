//
//  TinderContainerView.swift
//  CustomCollectionViewLayout
//
//  Created by SaiKiran Panuganti on 22/10/21.
//

import UIKit

protocol TinderContainerViewDataSource: AnyObject {
    var data: [TinderCardViewDataSource] {get}
}

class TinderContainerView: UIView {
    weak var dataSource: TinderContainerViewDataSource? {
        didSet {
            reloadData()
        }
    }
    
    var cardViews : [TinderCardView] = []
    var numberOfCardsToShow: Int = 0
    var remainingcards: Int = 0
    var cardsToBeVisible: Int = 3
    var currentIndex: Int = 0
    
    var visibleCards: [TinderCardView] {
        return subviews as? [TinderCardView] ?? []
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        removeAllCardViews()
        guard let datasource = dataSource else { return }
        setNeedsLayout()
        layoutIfNeeded()
        numberOfCardsToShow = datasource.data.count
        remainingcards = numberOfCardsToShow
        currentIndex = cardsToBeVisible - 1
        
        for i in 0..<min(numberOfCardsToShow,cardsToBeVisible) {
            let card = TinderCardView()
            card.dataSource = datasource.data[i]
            
            addCardView(cardView: card, atIndex: i )
        }
    }
    
    private func addCardView(cardView: TinderCardView, atIndex index: Int) {
        cardView.delegate = self
        addCardFrame(index: index, cardView: cardView)
        cardViews.append(cardView)
        insertSubview(cardView, at: 0)
        remainingcards -= 1
    }
    
    func addCardFrame(index: Int, cardView: TinderCardView) {
        let cardViewFrame = bounds
//        let horizontalInset = (CGFloat(index) * self.horizontalInset)
//        let verticalInset = CGFloat(index) * self.verticalInset
//
//        cardViewFrame.size.width -= 2 * horizontalInset
//        cardViewFrame.origin.x += horizontalInset
//        cardViewFrame.origin.y += verticalInset
        
        cardView.frame = cardViewFrame
    }
    
    private func removeAllCardViews() {
        for cardView in visibleCards {
            cardView.removeFromSuperview()
        }
        cardViews = []
    }
    
}

extension TinderContainerView: TinderCardViewDelegate {
    func swipeDidEnd(on view: TinderCardView) {
        guard let datasource = dataSource else { return }
        view.removeFromSuperview()
        
        if (currentIndex + 1) < datasource.data.count {
            let card = TinderCardView()
            card.dataSource = datasource.data[currentIndex + 1]
            addCardView(cardView: card, atIndex: 2)
            
            currentIndex += 1
        }else {
            currentIndex = 0
            
            let card = TinderCardView()
            card.dataSource = datasource.data[currentIndex]
            addCardView(cardView: card, atIndex: 2)
        }
    }
}
