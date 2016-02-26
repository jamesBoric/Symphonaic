//
//  MusicSheetViewController.swift
//  Symphonaic
//
//  Created by James Boric on 4/11/2015.
//  Copyright © 2015 Ode To Code. All rights reserved.
//

import UIKit

class MusicSheetViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    let reuseIdentifier = "cell"
    
    var pieceInfo = Piece()
    
    var totalBarCount : [Int] = []
    
    var numberOfBarsInPage = 50
    
    var numberOfBars = 50
    
    var numberOfPages = 0
    
    var pageNumber = 0
    
    @IBOutlet weak var musicSheetScrollView: UIScrollView!
    
    var stavesCollectionView: UICollectionView!
    
    var stavesCollectionViewFrame = CGRect()
    
    let titleLabel = UILabel()
    
    let composerLabel = UILabel()
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var numberOfSections = 0
    
    var didRotateView = false
    
    var givenSectionHeight: CGFloat = 0
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        var templateArray: [Int] = []
        
        for n in 0..<pieceInfo.instruments.count {
        
            templateArray.append(0)
        }
       
        totalBarCount = templateArray
        
        if didRotateView {
        
            stavesCollectionView.removeFromSuperview()
            
        }
        
        didRotateView = true
        
        musicSheetScrollView.contentSize = CGSize(width: view.frame.size.width, height: (view.frame.size.width) * sqrt(2))
        
        if pageNumber == 0 {
           
            stavesCollectionView = UICollectionView(frame: CGRectMake(8, 160, view.frame.size.width - 16, musicSheetScrollView.contentSize.height - 168), collectionViewLayout: layout)
        }
        
        else {
            
            stavesCollectionView = UICollectionView(frame: CGRectMake(8, 8, view.frame.size.width - 16, musicSheetScrollView.contentSize.height - 16), collectionViewLayout: layout)
        }
        
        layout.itemSize = CGSize(width: stavesCollectionView.frame.size.width, height: 35)
        
        layout.minimumLineSpacing = 85
        
        layout.sectionInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
        
        stavesCollectionView.backgroundColor = UIColor.clearColor()
        
        stavesCollectionView.dataSource = self
        
        stavesCollectionView.delegate = self
        
        self.stavesCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        titleLabel.frame = CGRectMake(8, 8, view.frame.size.width - 16, 100)
        
        titleLabel.text = pieceInfo.compositionTitle
        
        titleLabel.font = UIFont.systemFontOfSize(40)
        
        titleLabel.textAlignment = .Center
        
        composerLabel.frame = CGRectMake(8, titleLabel.frame.size.height + titleLabel.frame.origin.y + 8, titleLabel.frame.size.width, 30)
        
        composerLabel.text = pieceInfo.composer
        
        composerLabel.textAlignment = .Right
        
        if pageNumber == 0 {
           
            musicSheetScrollView.addSubview(titleLabel)
            
            musicSheetScrollView.addSubview(composerLabel)
        }
        
        musicSheetScrollView.addSubview(stavesCollectionView)
        
        givenSectionHeight = CGFloat(pieceInfo.instruments.count) * layout.itemSize.height + CGFloat(pieceInfo.instruments.count - 1) * layout.minimumLineSpacing + layout.sectionInset.bottom + layout.sectionInset.top
        
        numberOfSections = Int(floor(stavesCollectionView.frame.size.height / givenSectionHeight))
        
        
        numberOfPages = Int(ceil(Float(numberOfBarsInPage) / Float(numberOfSections * 4)))
        
        let musicPages = self.storyboard!.instantiateViewControllerWithIdentifier("musicPages") as! MusicPagesViewController
        
        musicPages.numberOfPages = numberOfPages
        
        let pageNumberLabel = UILabel(frame: CGRectMake(8, musicSheetScrollView.contentSize.height - 50, musicSheetScrollView.contentSize.width - 16, 42))
        
        pageNumberLabel.text = "\(pageNumber + 1)"
        
        musicSheetScrollView.addSubview(pageNumberLabel)
       
        if pageNumber % 2 == 0 {
        
            pageNumberLabel.textAlignment = .Left
        }
        
        else {
        
            pageNumberLabel.textAlignment = .Right
        }
        
        
        
        // Do any additional setup after loading the view.
    
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return numberOfSections
    
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pieceInfo.instruments.count
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell!
        
        let barStackView = UIStackView(frame: CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height))
        
        barStackView.axis = .Horizontal
        
        barStackView.alignment = .Fill
        
        barStackView.distribution = .FillProportionally
        
        cell.addSubview(barStackView)
        
        
        
        for i in 0..<4 {
            var barView = UIView()
            
            if totalBarCount[indexPath.row] < numberOfBarsInPage {
                
                if pageNumber == 0 && indexPath.section == 0 && i == 0 {
                    
                    let instrumentLabel = UILabel(frame: CGRectMake(0, 0, cell.frame.size.width / 4, 35))
                    
                    instrumentLabel.text = "\(pieceInfo.instruments[indexPath.row])"
                    
                    instrumentLabel.textAlignment = .Center
                    
                    barView.addSubview(instrumentLabel)
                }
                
                else {
                
                    barView = BarControl()
                }
                
            }
            
            else {
                barView = UIView()
            }
            
            barStackView.addArrangedSubview(barView)
            
            totalBarCount[indexPath.row]++
        }
        
        
        return cell
        
    }

    
}
