//
//  ViewController.swift
//  Symphonaic
//
//  Created by James Boric on 18/09/2015.
//  Copyright © 2015 Ode To Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate, UINavigationBarDelegate {
    
    @IBOutlet weak var setupView: UIView!
    
    var circleMinimum: CGFloat = 0
    
    @IBOutlet weak var compositionsPanel: UIView!
    
    let piece = Piece()
    
    //Visible setup circle
    let setupGraphicLayer = CAShapeLayer()
    
    //Light blue
    let accentColour = UIColor(red: 58 / 255, green: 131 / 255, blue: 255 / 255, alpha: 1)
    
    //Proportions of growth for circle origin and dimensions
    var intendedYGrowth: CGFloat = 0
    
    var intendedXGrowth: CGFloat = 0
    
    var tempo = 120.0
    
    //Circle interface misc.
    var arrow = UIImageView()
    
    let arrowContainer = UIImageView()
    
    let setupElementsView = UIView()
    
    let compositionNameTextField = UITextField()
    
    let composerTextField = UITextField()
    
    let instrumentsView = UIView()
    
    let titleBar = UINavigationBar()
    
    let chosenInstrumentsTable = UITableView()
    
    var selectedInstruments : [String] = []
    
    let sansLabel = UILabel()
    
    let keyView = UIView()
    
    let keyNameLabel = UILabel()
    
    let keyPicker = UIPickerView()
    
    let staveImage = UIImageView(image: UIImage(named: "blankStave"))
    
    let tempoView = UIView()
    
    let tempoButton = UIButton()
    
    let tempoGraphicView = UIView()
    
    let tempoLabel = UILabel()
    
    let tempoChangeCurve = CAShapeLayer()
    
    let timeSigView = UIView()
    
    let timeSigPicker = UIPickerView()
    
    let timeSigDict: [Int: String] = [1 : "One", 2 : "Two", 3 : "Three", 4 : "Four", 5 : "Five", 6 : "Six", 7 : "Seven", 8 : "Eight", 9 : "Nine", 10 : "Ten", 11 : "Eleven", 12 : "Twelve", 13 : "Thirteen", 14 : "Fourteen", 15 : "Fifteen", 16 : "Sixteen"]
    
    let timeSigData = [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16], [2, 4, 8, 16]]
    
    let timeSigLabel1 = UILabel()
    
    let timeSigLabel2 = UILabel()
    
    let timeSigDescLabel = UILabel()
    
    var instrumentsDict: NSDictionary?
    
    var instrumentKeys : [String] = []
    
    var instrumentPreserve : [String] = []
    
    let createPieceButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Primary view is setup (which users see)
        
        //The setup dot on the side
        setupElementsView.hidden = true
        
        setupElementsView.alpha = 0
        
        setupElementsView.frame = CGRectMake(0, 0, contextShortestSide, contextShortestSide)
        
        setupElementsView.layer.cornerRadius = contextShortestSide / 2
        
        //The text field for compositions
        compositionNameTextField.frame = CGRectMake(
            setupElementsView.frame.size.width / 2 - (setupElementsView.frame.size.width / 2) / sqrt(2),
            setupElementsView.frame.size.width / 2 - (setupElementsView.frame.size.width / 2) / sqrt(2),
            setupElementsView.frame.size.width / sqrt(2),
            50
        )
        
        //The grey stroke under the composition namere
        let titleUnderLine = UIView(frame: CGRectMake(
            compositionNameTextField.frame.origin.x,
            compositionNameTextField.frame.origin.y + compositionNameTextField.frame.size.height + 1,
            compositionNameTextField.frame.size.width,
            1
            )
        )
        
        titleUnderLine.backgroundColor = UIColor.grayColor()
        
        setupElementsView.addSubview(titleUnderLine)
        
        //Additional setup of the composition name text field
        compositionNameTextField.placeholder = "Composition Title"
        
        compositionNameTextField.font = UIFont(name: "Helvetica Neue", size: 50)
        
        //Name of composer text field setup
        composerTextField.frame = CGRectMake(
            compositionNameTextField.frame.origin.x,
            titleUnderLine.frame.origin.y + 2,
            compositionNameTextField.frame.size.width,
            25
        )
        
        composerTextField.textAlignment = .Right
        
        composerTextField.placeholder = "Composer"
        
        composerTextField.font = UIFont(name: "Helvetica Neue", size: 25)
        
        //TableView containing instruments in setupView
        instrumentsView.frame.size.width = 400
        instrumentsView.frame = CGRectMake(
            (setupElementsView.frame.size.width - instrumentsView.frame.size.width) / 2,
            composerTextField.frame.origin.y + composerTextField.frame.size.height + 2,
            instrumentsView.frame.size.width,
            215
        )
        
        instrumentsView.backgroundColor = UIColor(red: 220 / 256, green: 220 / 256, blue: 220 / 256, alpha: 1)
        
        instrumentsView.clipsToBounds = true
       
        instrumentsView.layer.cornerRadius = 15
        
        //TitleBar in the instruments table view
        titleBar.frame = CGRectMake(
            0,
            0,
            instrumentsView.frame.size.width,
            44
        )
        
        titleBar.delegate = self
        
        //Housing for navigation buttons
        let instrumentsNavItem = UINavigationItem()
        
        instrumentsNavItem.title = "My Instruments"
        
        //'+' button
        let rightAddButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "instrumentAdd")
        
        instrumentsNavItem.rightBarButtonItem = rightAddButton
        
        titleBar.items = [instrumentsNavItem]
        
        //Currently selected instruments
        chosenInstrumentsTable.frame = CGRectMake(0, 44, instrumentsView.frame.size.width, instrumentsView.frame.size.height - 44)
        
        chosenInstrumentsTable.dataSource = self
        
        chosenInstrumentsTable.delegate = self
        
        chosenInstrumentsTable.backgroundColor = UIColor.clearColor()
        
        chosenInstrumentsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        instrumentsView.addSubview(chosenInstrumentsTable)
        
        if selectedInstruments.count == 0 {
            chosenInstrumentsTable.hidden = true
            
            sansLabel.frame = CGRectMake(0, 44, instrumentsView.frame.size.width, instrumentsView.frame.size.height - 44)
            
            sansLabel.text = "Looks like you have no instruments. Tap the '+' button to get started."
            
            sansLabel.textAlignment = .Center
            
            sansLabel.numberOfLines = 2
            
            instrumentsView.addSubview(sansLabel)
        }
        
        instrumentsView.addSubview(titleBar)
        
        //Setup of key selection view
        keyView.frame.size.width = 300
        
        keyView.frame = CGRectMake(
            (setupElementsView.frame.size.width - keyView.frame.size.width) / 2,
            setupElementsView.frame.size.height - 150,
            keyView.frame.size.width,
            75
        )
        
        keyView.layer.cornerRadius = 15
        
        keyView.backgroundColor = UIColor.whiteColor()
        
        //Sliding picker with key signature images
        keyPicker.frame.origin.x = 10
        
        keyPicker.frame.size.height = 200
        
        keyPicker.frame = CGRectMake(
            keyPicker.frame.origin.x,
            (keyView.frame.size.height - keyPicker.frame.size.height) / 2,
            100,
            keyPicker.frame.size.height
        )
        
        keyPicker.dataSource = self
        
        keyPicker.delegate = self
        
        keyPicker.tag = 1
        
        keyNameLabel.frame = CGRectMake(
            keyPicker.frame.origin.x + keyPicker.frame.size.width + 10,
            0,
            100,
            keyView.frame.size.height
        )
        
        //Changing name of key signature label
        keyNameLabel.numberOfLines = 3
        
        keyNameLabel.text = "C Major\n\nA Minor"
        
        //The 5-line image behind the picker
        staveImage.frame = CGRectMake(keyPicker.frame.origin.x, 0, keyPicker.frame.size.width, keyView.frame.size.height)
        
        staveImage.contentMode = .ScaleAspectFit
        
        //Bulk addition of elements to keyView
        keyView.addSubview(staveImage)
        
        keyView.addSubview(keyPicker)
        
        keyView.addSubview(keyNameLabel)
        
        //Begin tempoView
        tempoView.frame.size = CGSizeMake(300, 75)
       
        tempoView.frame = CGRectMake(
            setupElementsView.frame.size.width / 4 - tempoView.frame.size.width / 2,
            (instrumentsView.frame.origin.y + instrumentsView.frame.size.height + keyView.frame.origin.y - tempoView.frame.size.height) / 2,
            tempoView.frame.size.width,
            tempoView.frame.size.height
        )
        
        tempoView.backgroundColor = UIColor.whiteColor()
        
        tempoView.layer.cornerRadius = 15
        
        //'Tap to set tempo' button setup
        tempoButton.frame = CGRectMake(
            10,
            10,
            tempoView.frame.size.width - tempoView.frame.size.height - 10,
            55
        )
        
        tempoButton.backgroundColor = UIColor.darkGrayColor()
        
        tempoButton.layer.cornerRadius = 8
        
        tempoButton.setTitle("Tap to set tempo", forState: .Normal)
        
        tempoButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        
        //Timing function to determine tempo in BPM
        tempoButton.addTarget(self, action: "testTempo", forControlEvents: UIControlEvents.TouchDown)
        
        tempoView.addSubview(tempoButton)
        
        //Rotating indicator of tempo
        tempoGraphicView.frame = CGRectMake(
            tempoButton.frame.origin.x + tempoButton.frame.size.width,
            0,
            tempoView.frame.size.height,
            tempoView.frame.size.height
        )
        
        tempoView.addSubview(tempoGraphicView)
        
        //Text inside of tempoGraphic
        tempoLabel.frame = CGRectMake(0, 0, tempoGraphicView.frame.size.width, tempoGraphicView.frame.size.height)
        
        tempoLabel.textAlignment = .Center
        
        tempoGraphicView.addSubview(tempoLabel)
        
        tempoLabel.text = "120"
        
        //Bezier drawing of 3/4 circle used in tempoView
        let tempoCurveView = UIView(frame: CGRectMake(10, 10, tempoGraphicView.frame.size.height - 20, tempoGraphicView.frame.size.width - 20))
        
        let tempoGraphic = CAShapeLayer()
        
        tempoGraphic.path = UIBezierPath(ovalInRect: CGRectMake(0, 0, tempoCurveView.frame.size.width, tempoCurveView.frame.size.height)).CGPath
        
        tempoGraphic.lineWidth = 10
        
        tempoGraphic.strokeColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5).CGColor
        
        tempoGraphic.fillColor = UIColor.clearColor().CGColor
        
        tempoGraphic.strokeStart = 1 / 4
        
        
        tempoGraphicView.addSubview(tempoCurveView)
        //Commencement of changing tempo by sliding up/down
        let dragActivButton = UIButton(
            frame: CGRectMake(
                0,
                0,
                tempoGraphicView.frame.size.width,
                tempoGraphicView.frame.size.height
            )
        )
        
        //Addition of method to drag tempo up/down
        dragActivButton.addTarget(self, action: "dragBegin", forControlEvents: .TouchDown)
        
        tempoGraphicView.addSubview(dragActivButton)
        
        //bezier changes in response to changes in tempo
        tempoChangeCurve.path = UIBezierPath(ovalInRect: CGRectMake(0, 0, tempoCurveView.frame.size.width, tempoCurveView.frame.size.height)).CGPath
        
        tempoChangeCurve.lineWidth = 10
        
        tempoChangeCurve.strokeColor = UIColor.blueColor().CGColor
        
        tempoChangeCurve.fillColor = UIColor.clearColor().CGColor
        
        tempoChangeCurve.strokeStart = 1 / 4
        
        tempoChangeCurve.strokeEnd = 5 / 8
        
        tempoCurveView.layer.addSublayer(tempoGraphic)
        
        tempoCurveView.layer.addSublayer(tempoChangeCurve)
        
        tempoCurveView.transform = CGAffineTransformMakeRotation(45 * CGFloat(M_PI) / CGFloat(180.0))
        
        //Recognizer to activate when drag tempo is used
        let tempoPanRec = UIPanGestureRecognizer()
        
        tempoPanRec.addTarget(self, action: "changeTempo:")
        
        tempoGraphicView.addGestureRecognizer(tempoPanRec)
        
        tempoGraphicView.userInteractionEnabled = true
        
        //Begin time signature view
        timeSigView.frame = CGRectMake(
            (3 * setupElementsView.frame.size.width) / 4 - tempoView.frame.size.width / 2,
            tempoView.frame.origin.y,
            tempoView.frame.size.width,
            tempoView.frame.size.height
        )
        
        timeSigView.backgroundColor = UIColor.whiteColor()
        
        timeSigView.layer.cornerRadius = 15
        
        //Picker with time signature values
        timeSigPicker.frame.size.height = 150
        
        timeSigPicker.frame = CGRectMake(
            10,
            (timeSigView.frame.size.height - timeSigPicker.frame.size.height) / 2,
            100,
            timeSigPicker.frame.size.height
        )
        
        timeSigPicker.tag = 2
        
        timeSigPicker.delegate = self
        
        timeSigPicker.dataSource = self
        
        //View which contains the visual of the time signature
        let timeSigFracView = UIView()
        
        timeSigFracView.frame.size.height = timeSigView.frame.size.height - 2 * 10
        
        timeSigFracView.frame = CGRectMake(
            timeSigPicker.frame.origin.x + timeSigPicker.frame.size.width + 10,
            10,
            timeSigFracView.frame.size.height / 2,
            timeSigFracView.frame.size.height
        )
        
        //The numerator of the timeSigFracView
        timeSigLabel1.frame = CGRectMake(
            0,
            0,
            timeSigFracView.frame.size.height / 2,
            timeSigFracView.frame.size.height / 2
        )
        
        timeSigLabel1.text = "4"
        
        timeSigLabel1.textAlignment = .Center
        
        //Denominator of ^^^^^
        timeSigLabel2.frame = CGRectMake(
            0,
            timeSigFracView.frame.size.height / 2,
            timeSigLabel1.frame.size.width,
            timeSigLabel1.frame.size.height
        )
        
        timeSigLabel2.textAlignment = .Center
        
        timeSigLabel2.text = "4"
        
        //Numbers-to-words label on the right
        timeSigDescLabel.frame.origin.x = timeSigFracView.frame.origin.x + timeSigFracView.frame.size.width + 10
        timeSigDescLabel.frame = CGRectMake(
            timeSigDescLabel.frame.origin.x,
            0,
            timeSigView.frame.size.width - timeSigDescLabel.frame.origin.x,
            timeSigView.frame.size.height
        )
        
        
        timeSigDescLabel.numberOfLines = 2
        
        timeSigDescLabel.textAlignment = .Center
        
        timeSigDescLabel.text = "Four-four time"
        
        //bulk addition of view to timeSigView
        timeSigView.addSubview(timeSigDescLabel)
        
        timeSigFracView.addSubview(timeSigLabel2)
        
        timeSigFracView.addSubview(timeSigLabel1)
        
        timeSigView.addSubview(timeSigFracView)
        
        timeSigView.addSubview(timeSigPicker)
        
        //Reading of instruents for population of instruments table view
        var myDict: NSDictionary?
        if let path = NSBundle.mainBundle().pathForResource("instruments", ofType: "plist") {
            
            myDict = NSDictionary(contentsOfFile: path)
            
            instrumentsDict = myDict
            
            instrumentKeys = (instrumentsDict?.allKeys as! [String]).sort()
            
            instrumentPreserve = instrumentKeys
        }
        
        //Button on the top to create the piece
        createPieceButton.frame.size.width = 200
        
        createPieceButton.frame = CGRectMake((setupElementsView.frame.size.width - createPieceButton.frame.size.width) / 2, 50, createPieceButton.frame.size.width, 50)
        
        createPieceButton.setTitle("Create composition", forState: .Normal)
        
        createPieceButton.addTarget(self, action: "createCompoTemplate", forControlEvents: UIControlEvents.TouchUpInside)
        
        //Bulk addition of all composition configuration to setupElementsView
        setupElementsView.addSubview(createPieceButton)
        
        setupElementsView.addSubview(timeSigView)
        
        setupElementsView.addSubview(tempoView)
        
        setupElementsView.addSubview(keyView)
        
        setupElementsView.addSubview(instrumentsView)
        
        setupElementsView.addSubview(composerTextField)
        
        setupElementsView.addSubview(compositionNameTextField)
        
        setupView.addSubview(setupElementsView)
        
        circleMinimum = setupView.frame.size.width
        
        
        
        //General setup of blue dot on the right
        
        //The circle a user sees on the right
        let setupGraphic = UIBezierPath(ovalInRect: CGRectMake(0, 0, setupView.frame.size.width, setupView.frame.size.height))
        
        //Being added to a CAShapeLayer to make it visible
        setupGraphicLayer.path = setupGraphic.CGPath
        
        setupGraphicLayer.fillColor = accentColour.CGColor
        
        setupGraphicLayer.zPosition = -9999
        
        setupView.layer.addSublayer(setupGraphicLayer)
        
        arrowContainer.image = UIImage(named: "arrow")
       
        arrowContainer.contentMode = .ScaleAspectFit
        
        arrowContainer.frame = CGRectMake(0, 0, circleMinimum, circleMinimum)
        
        setupView.addSubview(arrowContainer)
        
        setupView.clipsToBounds = true
        
    }
    //===================================================
    //Manage the presentation of selection of instruments
    //===================================================
    func instrumentAdd() {
        
        //Saved for re-presentation of selected instruments
        instrumentKeys = instrumentPreserve
        
        //The data is changed to selectable instruments
        chosenInstrumentsTable.reloadData()
        
        sansLabel.hidden = true
        
        chosenInstrumentsTable.hidden = false
        
        //Cancel button
        let instrumentsCancelNavItem = UINavigationItem()
        
        instrumentsCancelNavItem.title = "Add Instrument"
        
        //Back button
        let leftBackButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: nil)
        
        instrumentsCancelNavItem.leftBarButtonItem = leftBackButton
        
        //Addition to navigation bar
        titleBar.items = [instrumentsCancelNavItem]
    }
    
    //==============================================
    //Basic composition setup elements are pre-setup
    //==============================================
    override func viewDidAppear(animated: Bool) {
        
        keyPicker.selectRow(7, inComponent: 0, animated: false)
        
        timeSigPicker.selectRow(3, inComponent: 0, animated: false)
        
        timeSigPicker.selectRow(1, inComponent: 1, animated: false)
    }
    //===================================================================
    //Implementation for dragging up/down on graphic view to change tempo
    //===================================================================
    var tempoPreserve = 0.0
    
    func dragBegin() {
        //Change the label if it is not appropriate for the limitation of the app
        
        //Do not allow tempo above 220...
        if tempo > 220 {
            
            tempo = 220
        }
        //Or below 20
        else if tempo < 20 {
            
            tempo = 20
        }
        //Preserved for natural progression for next use
        tempoPreserve = tempo
        
    }
    
    //==========================================
    //Implementation of change on drag for tempo
    //==========================================
    func changeTempo(sender: UIPanGestureRecognizer) {
        
        //Total translation from original point of contact for addition or subtraction from current tempo
        let totalTranslation = Int(-sender.translationInView(view).y)
        
        //Increases/decreases tempo by factor 1/2 of pt difference from original touch
        tempo = Double(totalTranslation / 2) + tempoPreserve
        
        if tempo > 220 {
            
            tempo = 220
        }
            
        else if tempo < 20 {
            
            tempo = 20
        }
        
        //Formatted for presentation label
        tempoLabel.text = "\(Int(round(tempo)))"
        
        tempoChangeCurve.strokeEnd = CGFloat((3 * (tempo - 20)) / 800 + 1 / 4)
    }
    
    //'Tap to set tempo' implementation
    var earlier: NSDate = NSDate()
    
    var intervals: [Double] = []
    //=============================================================================
    //Finds date difference between current and previous tap, uses that to find BPM
    //=============================================================================
    func testTempo() {
    
        let interval = NSDate().timeIntervalSinceDate(earlier)
        
        earlier = NSDate()
        
        if intervals.count == 3 {
        
            intervals = Array(intervals[1..<3])
        }
        
        intervals.append(interval)
        
        var intervalsAve = 0.0
        
        for i in intervals {
            
            intervalsAve += i
        }
        
        intervalsAve /= Double(intervals.count)
        
        tempo = 60 / intervalsAve
        
        tempo = round(tempo)
        
        tempoLabel.text = "\(Int(tempo))"
        
        tempoChangeCurve.strokeEnd = CGFloat((3 * (tempo - 20)) / 800 + 1 / 4)
    }
    
    //Make status ar white
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if view.frame.size.width > view.frame.size.height {
            
            intendedYGrowth = (view.frame.size.height - 62) / 2
            
            intendedXGrowth = view.frame.size.width - 62 - (view.frame.size.width - view.frame.size.height) / 2
        }
            
        else {
            
            intendedYGrowth = (view.frame.size.height - 62) / 2 - (view.frame.size.height - view.frame.size.width) / 2
            
            intendedXGrowth = view.frame.size.width - 62
        }
    }
    
    var contextOrientationBarrier: CGFloat {
       
        return view.frame.size.width < view.frame.size.height ? 0 : (view.frame.size.width - view.frame.size.height) / 2
    }
    
    var contextAbsMaxBarrier: CGFloat {
      
        return view.frame.size.width < view.frame.size.height ? -100 : 0
    }
    
    
    var contextShortestSide: CGFloat {
       
        return view.frame.size.width < view.frame.size.height ? view.frame.size.width : view.frame.size.height
    }
    
    var arrowMoveScale: CGFloat {
        let totalGrowth = view.frame.size.width - 62 - contextOrientationBarrier
        
        let arrowDist = (view.frame.size.width - circleMinimum) / 2 - contextOrientationBarrier
        
        return arrowDist / totalGrowth
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //The rubber band effect for the dot when moved beyond boundaries
        var moveScale: CGFloat {
            
            var closestEdgeDist: CGFloat {
                
                return setupView.frame.origin.x < view.frame.size.width - setupView.frame.origin.x ? setupView.frame.origin.x : view.frame.size.width - setupView.frame.origin.x
            }
            
            var barrierScale: CGFloat {
               
                return view.frame.size.width < view.frame.size.height && setupView.frame.origin.x > view.frame.size.width - 62 ? closestEdgeDist / 62 : fabs(closestEdgeDist - contextAbsMaxBarrier) / fabs(contextAbsMaxBarrier - contextOrientationBarrier)
            }
            
            //let barrierScale = fabs(closestEdgeDist - contextAbsMaxBarrier) / fabs(contextAbsMaxBarrier - contextOrientationBarrier)
            
            return setupView.frame.origin.x < contextOrientationBarrier || setupView.frame.origin.x > view.frame.size.width - 62 ? barrierScale : 1
        }
        //End Barriers
        
        //Begin move horizontal
        let touch = touches.first as UITouch!
        
        let currentTouch = touch.locationInView(self.view).x
        
        let prevTouch = touch.previousLocationInView(self.view).x
        
        let xDiff = currentTouch - prevTouch
        
        setupView.frame.origin.x += xDiff * moveScale
        //End move horizontal
        
        
        if (setupView.frame.origin.x > (view.frame.size.width - view.frame.size.height) / 2 && view.frame.size.width > view.frame.size.height && setupView.frame.size.height > circleMinimum) || (setupView.frame.origin.x > 0 && view.frame.size.width < view.frame.size.height && setupView.frame.size.height > circleMinimum) || (setupView.frame.size.height == circleMinimum && xDiff < 0 && setupView.frame.origin.x <= view.frame.size.width - 62) {
                
            setupElementsView.alpha = 0
            
            setupElementsView.hidden = true
            //Begin move vertical
            let yGrowthRatio = intendedYGrowth / intendedXGrowth
            
            setupView.frame.origin.y += xDiff * yGrowthRatio
            //End move vertical
            compositionsPanel.frame.origin.x += xDiff * 2
            
            arrowContainer.frame.origin.x -= xDiff * arrowMoveScale
            
            arrowContainer.frame.origin.y -= xDiff * arrowMoveScale
            
            let totalDist = (view.frame.size.width - contextOrientationBarrier - (contextShortestSide - circleMinimum) / 2 - 62) / 2
            
            let currentDist = (setupView.frame.origin.x + arrowContainer.frame.origin.x) - (contextOrientationBarrier + (contextShortestSide - circleMinimum) / 2) - totalDist
            
            arrowContainer.alpha = currentDist / totalDist
            
            
            //Resize
            if view.frame.size.height > view.frame.size.width {
                setupView.frame.size.height -= xDiff * yGrowthRatio * 2 * (1 + (6 / view.frame.size.width))
            
                setupView.frame.size.width -= xDiff * yGrowthRatio * 2 * (1 + (6 / view.frame.size.width))
            }
            else {
                setupView.frame.size.height -= xDiff * yGrowthRatio * 2
            
                setupView.frame.size.width -= xDiff * yGrowthRatio * 2
            }
        }
            
        else if setupView.frame.origin.x >= view.frame.size.width - 62 {
           
            setupView.frame.origin.y = (view.frame.size.height - circleMinimum) / 2
            
            setupView.frame.size.height = circleMinimum
            
            setupView.frame.size.width = circleMinimum
            
            compositionsPanel.frame.origin.x = 0
            
            arrowContainer.frame.origin.x = 0
            
            arrowContainer.frame.origin.y = 0
        }
            
        else if setupView.frame.origin.x <= (view.frame.size.width - view.frame.size.height) / 2 && view.frame.size.width > view.frame.size.height {
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: ({
                
                self.setupElementsView.alpha = 1
                
            }),completion: { (Bool) in
                self.setupElementsView.hidden = false
            })
            
            
            
            setupView.frame.origin.y = 0
            
            setupView.frame.size.height = view.frame.size.height
            
            setupView.frame.size.width = view.frame.size.height
            
            arrowContainer.frame.origin.x = (setupView.frame.size.width - circleMinimum) / 2
           
            arrowContainer.frame.origin.y = arrowContainer.frame.origin.x
        }
            
        else if setupView.frame.origin.x <= 0 {
            
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: ({
                
                self.setupElementsView.alpha = 1
                
            }),completion: { (Bool) in
                self.setupElementsView.hidden = false
            })
            
            setupView.frame.origin.y = (view.frame.size.height - view.frame.size.width) / 2
           
            setupView.frame.size.height = view.frame.size.width
            
            setupView.frame.size.width = view.frame.size.width
            
            arrowContainer.frame.origin.x = (setupView.frame.size.width - circleMinimum) / 2
            
            arrowContainer.frame.origin.y = arrowContainer.frame.origin.x
        }
        
        setupGraphicLayer.path = UIBezierPath(ovalInRect: CGRectMake(0, 0, setupView.frame.size.width, setupView.frame.size.height)).CGPath
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch = touches.first as UITouch!
        
        let currentTouch = touch.locationInView(self.view).x
        
        let prevTouch = touch.previousLocationInView(self.view).x
        
        let xDiff = currentTouch - prevTouch
        
        if self.setupView.frame.origin.x < self.contextOrientationBarrier || setupView.frame.origin.x >= view.frame.size.width - 62 {
            
            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.17, initialSpringVelocity: 5.0, options: .CurveEaseInOut, animations: ({
                if self.setupView.frame.origin.x >= self.view.frame.size.width - 62 {
                    
                    self.setupView.frame = CGRectMake(self.view.frame.size.width - 62, self.setupView.frame.origin.y, self.circleMinimum, self.circleMinimum)
                    
                    self.setupGraphicLayer.path = UIBezierPath(ovalInRect: CGRectMake(0, 0, self.circleMinimum, self.circleMinimum)).CGPath
                    
                    self.compositionsPanel.frame.origin.x = 0
                }
                else {
                    
                    self.setupView.frame = CGRectMake(
                        self.contextOrientationBarrier,
                        self.view.frame.size.width < self.view.frame.size.height ? (self.view.frame.size.height - self.view.frame.size.width) / 2 : 0,
                        self.contextShortestSide,
                        self.contextShortestSide
                    )
                    self.setupGraphicLayer.path = UIBezierPath(ovalInRect: CGRectMake(0, 0, self.contextShortestSide, self.contextShortestSide)).CGPath
                    
                    self.compositionsPanel.frame.origin.x = self.view.frame.size.width - 62 - 2 * (self.view.frame.size.width - self.contextOrientationBarrier - 62) - self.compositionsPanel.frame.size.width
                }
                
            }),completion: nil)
        }
            
        else {
            
            let totalAnimDuration: CFTimeInterval = 0.2
            if xDiff > 0 {
                UIView.animateWithDuration(totalAnimDuration, delay: 0.0, options: .CurveEaseInOut, animations: ({
                    
                    self.setupView.frame = CGRectMake(
                        self.view.frame.size.width - 62,
                        (self.view.frame.size.height - self.circleMinimum) / 2,
                        self.circleMinimum,
                        self.circleMinimum
                    )
                    
                    self.compositionsPanel.frame.origin.x = 0
                    
                    self.arrowContainer.frame.origin.x = 0
                    
                    self.arrowContainer.frame.origin.y = 0
                    
                    self.arrowContainer.alpha = 1
                    
                }),completion: { (Bool) in
                    
                    self.setupGraphicLayer.path = UIBezierPath(ovalInRect: CGRectMake(0, 0, self.circleMinimum, self.circleMinimum)).CGPath
                    
                })
                
                let endShape = UIBezierPath(ovalInRect: CGRectMake(0, 0, circleMinimum, circleMinimum)).CGPath
                
                let animation = CABasicAnimation(keyPath: "path")
                
                animation.toValue = endShape
                
                animation.duration = totalAnimDuration
                
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                
                
                setupGraphicLayer.addAnimation(animation, forKey: animation.keyPath)
                
            }
                
            else {
                
                UIView.animateWithDuration(totalAnimDuration, delay: 0.0, options: .CurveEaseInOut, animations: ({
                    
                    self.setupView.frame = CGRectMake(
                        self.contextOrientationBarrier,
                        self.contextOrientationBarrier == 0 ? (self.view.frame.size.height - self.view.frame.size.width) / 2 : 0,
                        self.contextShortestSide,
                        self.contextShortestSide
                    )
                    
                    self.arrowContainer.alpha = -1
                    
                    self.compositionsPanel.frame.origin.x = self.view.frame.size.width - 62 - 2 * (self.view.frame.size.width - self.contextOrientationBarrier - 62) - self.compositionsPanel.frame.size.width
                    
                    self.arrowContainer.frame.origin.x = (self.contextShortestSide - self.circleMinimum) / 2
                    
                    self.arrowContainer.frame.origin.y = (self.contextShortestSide - self.circleMinimum) / 2
                    
                }),completion: { (Bool) in
                    self.setupGraphicLayer.path = UIBezierPath(ovalInRect: CGRectMake(0, 0, self.contextShortestSide, self.contextShortestSide)).CGPath
                    
                    UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: ({
                        
                        self.setupElementsView.alpha = 1
                        
                    }),completion: nil)
                    
                    self.setupElementsView.hidden = false
                    
                })
                
                let endShape = UIBezierPath(ovalInRect: CGRectMake(0, 0, contextShortestSide, contextShortestSide)).CGPath
                
                let animation = CABasicAnimation(keyPath: "path")
                
                animation.toValue = endShape
                
                animation.duration = totalAnimDuration
                
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                
                setupGraphicLayer.addAnimation(animation, forKey: animation.keyPath)
                
            }
        }
    }
    
    let keys = ["C♯ Major", "F♯ Major", "B Major", "E Major", "A Major", "D Major", "G Major", "C Major", "F Major", "B♭ Major", "E♭ Major", "A♭ Major", "D♭ Major", "G♭ Major", "C♭ Major"]
    
    let keysMinorDict = ["C♯ Major" : "A♯ Minor", "F♯ Major" : "D♯ Minor", "B Major" : "G♯ Minor", "E Major" : "C♯ Minor", "A Major" : "F♯ Minor", "D Major" : "B Minor", "G Major" : "E Minor", "C Major" : "A Minor", "F Major" : "D Minor", "B♭ Major" : "G minor", "E♭ Major" : "C Minor", "A♭ Major" : "F Minor", "D♭ Major" : "B♭ Minor", "G♭ Major" : "E♭ Minor", "C♭ Major" : "A♭ Minor"]
    
    let keysEnumValue = ["C♯ Major" : KeySig.CSharpMajor, "F♯ Major" : KeySig.FSharpMajor, "B Major" : KeySig.BMajor, "E Major" : KeySig.EMajor, "A Major" : KeySig.AMajor, "D Major" : KeySig.DMajor, "G Major" : KeySig.GMajor, "C Major" : KeySig.CMajor, "F Major" : KeySig.FMajor, "B♭ Major" : KeySig.BFlatMajor, "E♭ Major" : KeySig.EFlatMajor, "A♭ Major" : KeySig.AFlatMajor, "D♭ Major" : KeySig.BFlatMajor, "G♭ Major" : KeySig.GFlatMajor, "C♭ Major" : KeySig.CFlatMajor]
    
    //Picker view is formatted depending on tag (1 = Key signature picker, 2 = time signature picker)
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        if pickerView.tag == 1 {
            return keyView.frame.size.height
        }
        
        return 25
        
    }
    
    //Number of components necessary in picker view are equal to its tag
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return pickerView.tag
    }
    
    //Implementation for each pickerView based on datas ource
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return keys.count
        }
            
        else if pickerView.tag == 2 {
            return timeSigData[component].count
        }
        return 10
        
    }
    
    //Allows images to be placed into the picker view cannot be used in conjuction with titleForRow, so a label is added to a view and place in the time signature picker.
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        if pickerView.tag == 1 {
            
            let image = UIImage(named: keys[row])
            
            let imageView = UIImageView(image: image)
            
            imageView.frame = CGRectMake(0, 4, keyPicker.frame.size.width, keyView.frame.size.height - 8)
            
            imageView.contentMode = .ScaleAspectFit
            
            return imageView
        }
            
        else if pickerView.tag == 2 {
            
            let myText = UILabel(frame: CGRectMake(0, 0, timeSigPicker.frame.size.width / 2, 25))
            
            myText.textAlignment = .Center
            
            myText.font = UIFont.systemFontOfSize(20)
            
            myText.text = "\(timeSigData[component][row])"
            
            return myText
        }
        return UIView()
    }
    
    //Update the necessary interface and data components for each picker view
    var currentSelectedKeySig : KeySig = KeySig.CMajor
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            
            let fileName = keys[row]
            
            keyNameLabel.text = "\(fileName)\n\n\(keysMinorDict[fileName]!)"
            
            currentSelectedKeySig = keysEnumValue[fileName]!
            
        }
            
        else if pickerView.tag == 2 {
            
            let numerator = timeSigData[0][pickerView.selectedRowInComponent(0)]
            
            let denom = timeSigData[1][pickerView.selectedRowInComponent(1)]
            
            timeSigLabel1.text = "\(numerator)"
            
            timeSigLabel2.text = "\(denom)"
            
            timeSigDescLabel.text = "\(timeSigDict[numerator]!)-\(timeSigDict[denom]!.lowercaseString) time"
            
            
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instrumentKeys.count
    }
    
    //Implementation using instrumentKeys : [String] as datasource. Is mutated by other part of code to change contents of table view.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        
        cell.backgroundColor = UIColor.clearColor()
        
        cell.textLabel?.text = self.instrumentKeys[indexPath.row]
        
        if !didSelectInstrumentSection {
            cell.accessoryType = .DisclosureIndicator
        }
        else {
            cell.accessoryType = .None
        }
        
        
        
        return cell
    }
    
    //Management of which data is used for the tableView as well as acessry view and navigation items.
    var didSelectInstrumentSection = false
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if !didSelectInstrumentSection {
            
            instrumentKeys = instrumentsDict![instrumentKeys[indexPath.row]] as! [String]
            
            didSelectInstrumentSection = true
            
        }
            
        else {
            
            let instrumentsNavItem = UINavigationItem()
            instrumentsNavItem.title = "My Instruments"
            
            let rightAddButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "instrumentAdd")
            
            instrumentsNavItem.rightBarButtonItem = rightAddButton
            
            titleBar.items = [instrumentsNavItem]
            
            didSelectInstrumentSection = false
            
            selectedInstruments += [instrumentKeys[indexPath.row]]
            
            instrumentKeys = selectedInstruments
        }
        
        tableView.reloadData()
    }
    
    //Creates instance of Piece() to describe composition.
    func createCompoTemplate() {
        
        piece.compositionTitle = compositionNameTextField.text!
        
        piece.composer = composerTextField.text!
        
        piece.finalTempo = Int(tempo)
        
        piece.timeSig = [timeSigData[0][timeSigPicker.selectedRowInComponent(0)], timeSigData[1][timeSigPicker.selectedRowInComponent(1)]]
        
        piece.instruments = selectedInstruments
        
        piece.keySignature = currentSelectedKeySig
        
        performSegueWithIdentifier("createPieceSegue", sender: nil)
        
    }
    
    
    //Passes the information to Notation Entry View controller.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "createPieceSegue" {
            
            let svc = segue.destinationViewController as! NotationEntryViewController
            
            svc.pieceBaseClass = piece
        }
    }
}