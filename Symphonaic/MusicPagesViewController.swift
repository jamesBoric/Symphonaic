//
//  MusicPagesViewController.swift
//  Symphonaic
//
//  Created by James Boric on 7/11/2015.
//  Copyright © 2015 Ode To Code. All rights reserved.
//

import UIKit

class MusicPagesViewController: UIViewController, UIPageViewControllerDataSource {
    
    private var musicPagesViewController : UIPageViewController?
    
    var numberOfPages = 5
    
    var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var stavesCollectionViewFrame = CGRect()
    
    var givenSectionHeight : CGFloat = 0
    
    //Mutated by NotationEntryViewController
    var pieceInfo = Piece()
    
    var numberOfSections = 0
    
    var numberOfBarsInPage = 0
    
    var numberOfBars = 50
    
    //viewDidLoad() not used because of assumed metrics
    override func viewDidLayoutSubviews() {
        
        //Initialisation of variable to calculate necessary number of pages for bars and number of intruments
        layout.itemSize = CGSize(width: stavesCollectionViewFrame.size.width, height: 35)
        
        layout.minimumLineSpacing = 85
        
        layout.sectionInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
        
        givenSectionHeight = CGFloat(pieceInfo.instruments.count) * layout.itemSize.height + CGFloat(pieceInfo.instruments.count - 1) * layout.minimumLineSpacing + layout.sectionInset.bottom + layout.sectionInset.top
        
        numberOfSections = Int(floor(stavesCollectionViewFrame.size.height / givenSectionHeight))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Used to Add the Paging view controller to the scroll view in MusicSheetViewController class
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        
        //Data managed
        pageController.dataSource = self
        
        let firstController = getItemController(0)!
        
        let startController: NSArray = [firstController]
        
        pageController.setViewControllers(startController as! [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        //Physically added to home screen
        musicPagesViewController = pageController
        
        addChildViewController(musicPagesViewController!)
        
        view.addSubview(musicPagesViewController!.view)
        
        musicPagesViewController!.didMoveToParentViewController(self)
        
        //Asthetics of page control
        let appearance = UIPageControl.appearance()
        
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        
        appearance.backgroundColor = UIColor.darkGrayColor()
        
        // Do any additional setup after loading the view.
    }
    
    //Instance of MusicSheetViewController setup for previous page
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! MusicSheetViewController
        
        if itemController.pageNumber > 0 {
            return getItemController(itemController.pageNumber - 1)
        }
        
        return nil
    }
    
    //Instance of MusicSheetViewController setup for following page
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! MusicSheetViewController
        
        if itemController.pageNumber + 1 < numberOfPages {
            
            return getItemController(itemController.pageNumber + 1)
        }
        
        return nil
    }
    
    //Basic information is passed to the MusicSheetViewController for setup
    private func getItemController(itemIndex: Int) -> MusicSheetViewController? {
        numberOfBarsInPage = numberOfSections * 4
        
        let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! MusicSheetViewController
        
        pageItemController.numberOfPages = numberOfPages
       
        pageItemController.numberOfBars = numberOfBars
        
        pageItemController.pieceInfo = pieceInfo
        
        pageItemController.pageNumber = itemIndex
        
        return pageItemController
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
