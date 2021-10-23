//
//  TinderCardView.swift
//  CustomCollectionViewLayout
//
//  Created by SaiKiran Panuganti on 22/10/21.
//

import UIKit

protocol TinderCardViewDelegate {
    func swipeDidEnd(on view: TinderCardView)
}

protocol TinderCardViewDataSource: AnyObject {
    var backGroundColor: UIColor {get}
}

class TinderCardView: UIView {
    
    var shadowView : UIView!
    var swipeView : UIView!
    
    var delegate : TinderCardViewDelegate?
    var dataSource: TinderCardViewDataSource? {
        didSet {
            swipeView.backgroundColor = dataSource?.backGroundColor
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureShadowView()
        configureSwipeView()
        addPanGestureOnCards()
        addTapGesture()
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureShadowView() {
        shadowView = UIView()
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowRadius = 4.0
        addSubview(shadowView)
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        shadowView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        shadowView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    func configureSwipeView() {
        swipeView = UIView()
        swipeView.layer.cornerRadius = 15
        swipeView.clipsToBounds = true
        shadowView.addSubview(swipeView)
        
        swipeView.translatesAutoresizingMaskIntoConstraints = false
        swipeView.leftAnchor.constraint(equalTo: shadowView.leftAnchor).isActive = true
        swipeView.rightAnchor.constraint(equalTo: shadowView.rightAnchor).isActive = true
        swipeView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor).isActive = true
        swipeView.topAnchor.constraint(equalTo: shadowView.topAnchor).isActive = true
    }
    
    func addPanGestureOnCards() {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
    
    func addTapGesture() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
    }
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer){
        let card = sender.view as! TinderCardView
        let point = sender.translation(in: self)
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        card.center = CGPoint(x: centerOfParentContainer.x + point.x, y: centerOfParentContainer.y + point.y)
        
//        let distanceFromCenter = ((UIScreen.main.bounds.width / 2) - card.center.x)
//        divisor = ((UIScreen.main.bounds.width / 2) / 0.61)
       
        switch sender.state {
        case .ended:
            if (card.center.x) > 300 {
                delegate?.swipeDidEnd(on: card)
                UIView.animate(withDuration: 0.4) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x + 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            }else if card.center.x < 50 {
                delegate?.swipeDidEnd(on: card)
                UIView.animate(withDuration: 0.4) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x - 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            }
            UIView.animate(withDuration: 0.2) {
                card.transform = .identity
                card.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                self.layoutIfNeeded()
            }
        case .changed:
            let rotation = tan(point.x / (self.frame.width * 2.0))
            card.transform = CGAffineTransform(rotationAngle: rotation)
            
        default:
            break
        }
    }
    
    @objc func handleTapGesture(sender: UITapGestureRecognizer){
    }
}
