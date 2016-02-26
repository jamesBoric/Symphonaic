//
//  BarControl.swift
//  Symphonaic
//
//  Created by James Boric on 4/11/2015.
//  Copyright © 2015 Ode To Code. All rights reserved.
//

import UIKit

class BarControl: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var placeNotesCollectionView: UICollectionView!
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let stavesStackView = UIStackView()
    
    override func layoutSubviews() {
        
        
        stavesStackView.userInteractionEnabled = false
        
        stavesStackView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        
        stavesStackView.axis = .Vertical
        
        stavesStackView.alignment = .Fill
        
        stavesStackView.distribution = .FillProportionally
        
        for i in 0..<4 {
            let stave = UIView()
            
            stave.layer.borderColor = UIColor.blackColor().CGColor
            
            stave.layer.borderWidth = 0.5
            
            stavesStackView.addArrangedSubview(stave)
        }
        
        
        
        layout.itemSize = CGSize(width: frame.size.width, height: (frame.size.height + frame.size.height / 8) / 9)
       
        layout.minimumLineSpacing = 0
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        placeNotesCollectionView = UICollectionView(frame: CGRectMake(0, -(1/4) * stavesStackView.frame.size.height / 4, frame.size.width, frame.size.height + stavesStackView.frame.size.height / 8), collectionViewLayout: layout)
        
        placeNotesCollectionView.backgroundColor = UIColor.clearColor()
        
        placeNotesCollectionView.allowsSelection = true
        
        placeNotesCollectionView.dataSource = self
        
        
        placeNotesCollectionView.delegate = self
        
        
        self.placeNotesCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "notesCell")
        
        
        
        addSubview(placeNotesCollectionView)
        
        addSubview(stavesStackView)

    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 9
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("notesCell", forIndexPath: indexPath) as UICollectionViewCell!
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //collectionView.cellForItemAtIndexPath(indexPath)?.backgroundView =
    }

}
