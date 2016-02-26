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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self
        
        let firstController = getItemController(0)!
        let startController: NSArray = [firstController]
        pageController.setViewControllers(startController as! [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        musicPagesViewController = pageController
        addChildViewController(musicPagesViewController!)
        self.view.addSubview(musicPagesViewController!.view)
        musicPagesViewController!.didMoveToParentViewController(self)
        
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
        

        // Do any additional setup after loading the view.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! MusicSheetViewController
        
        if itemController.pageNumber > 0 {
            return getItemController(itemController.pageNumber - 1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! MusicSheetViewController
        
        if itemController.pageNumber + 1 < 5 {
            return getItemController(itemController.pageNumber + 1)
        }
        
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getItemController(itemIndex: Int) -> MusicSheetViewController? {
        
        let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! MusicSheetViewController
        
        pageItemController.pageNumber = itemIndex
        
        return pageItemController
        
        return nil
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
