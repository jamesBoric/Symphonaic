//
//  NotationEntryViewController.swift
//  Symphonaic
//
//  Created by James Boric on 31/10/2015.
//  Copyright © 2015 Ode To Code. All rights reserved.
//

import UIKit

class NotationEntryViewController: UIViewController {
    
    //Array for universal behavioural implementation of sideBar note buttons
    @IBOutlet var selectableNotes: [UIButton]!
    
    //To be mutated by ViewController
    var pieceBaseClass = Piece()
    
    //Clears other buttons and highlights currently selected buttons.
    @IBAction func noteButtonSelected(sender: UIButton) {
        
        for n in selectableNotes {
        
            n.backgroundColor = UIColor.clearColor()
        }
        
        sender.backgroundColor = UIColor.darkGrayColor()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Content mode is changed for all buttons.
        for i in selectableNotes {
        
            i.imageView!.contentMode = .ScaleAspectFit
            
            i.layer.cornerRadius = 10
        }
    }
    
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Hide status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //Pass composition class to MusicPagesViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "musicPagesEmbedSegue" {
            
            let svc = segue.destinationViewController as! MusicPagesViewController
            
            svc.pieceInfo = pieceBaseClass
        }
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
