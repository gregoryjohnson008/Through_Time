//
//  ViewController.swift
//  Through Time
//
//  Created by Gregory Johnson on 2/26/15.
//  Copyright (c) 2015 Gregory Johnson. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet var backgroundImage: UIImageView!
    
    @IBOutlet weak var buttonAudio: UIButton!
    
    @IBOutlet weak var buttonMoney1: UIButton!
    @IBOutlet weak var buttonMoney2: UIButton!
    @IBOutlet weak var buttonMoney3: UIButton!
    @IBOutlet weak var buttonAttr1: UIButton!
    @IBOutlet weak var buttonAttr2: UIButton!
    
    @IBOutlet weak var button1Name: UILabel!
    @IBOutlet weak var button2Name: UILabel!
    @IBOutlet weak var button3Name: UILabel!
    @IBOutlet weak var button4Name: UILabel!
    @IBOutlet weak var button5Name: UILabel!
    
    @IBOutlet weak var buttonClicker: UIButton!
    
    @IBOutlet weak var labelMoney: UILabel!
    
    @IBOutlet weak var moneyPerSecondLabel: UILabel!
    
    @IBOutlet weak var BL1: UILabel!
    @IBOutlet weak var BL2: UILabel!
    @IBOutlet weak var BL3: UILabel!
    @IBOutlet weak var BL4: UILabel!
    @IBOutlet weak var BL5: UILabel!
    
    @IBOutlet weak var BC1: UILabel!
    @IBOutlet weak var BC2: UILabel!
    @IBOutlet weak var BC3: UILabel!
    @IBOutlet weak var BC4: UILabel!
    @IBOutlet weak var BC5: UILabel!
    
    let transitionManager = TransitionManager(direction: TransitionManager.Direction.down)
    
    var currentEra = EraSuperClass()
    
    var width:CGFloat = 0
    var length:CGFloat = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Starts music if not already on
        if(data_s.audioURL != nil && !data_s.musicStarted)
        {
            do{
            data_s.musicFile = try AVAudioPlayer(contentsOfURL: data_s.audioURL!)
            data_s.musicFile.numberOfLoops = -1 //negative number means loop indefinitely
            data_s.musicFile.play()
            data_s.musicIsPlaying = true
            data_s.musicStarted = true
            }catch let error as NSError{
                print("Error starting music: \(error)")
            }
        }
        
        if(data_s.musicIsPlaying)
        {
            buttonAudio.setImage(UIImage(named: "mute"), forState: .Normal)
        }
        else
        {
            buttonAudio.setImage(UIImage(named: "unmute"), forState: .Normal)
        }
        
        //Set up amount of money text
        self.labelMoney.text = String(format: "%i gold", data_s.money)
        
        //Set up money per second text
        self.moneyPerSecondLabel.text = String(format: "%i gold/second", data_s.perSec)
        
        //Set up button titles based on current Era
        switch data_s.timePeriod
        {
            case Game_s.Era.Caveman:
                currentEra = Era_Caveman()
            case Game_s.Era.AncientEgypt:
                self.buttonMoney1.setTitle("Eqypt", forState: UIControlState.Normal)
            default:
                print("Era not yet implemented")
        }
        
        buttonClicker.backgroundColor = UIColor.clearColor()
        buttonMoney1.backgroundColor = UIColor.clearColor()
        buttonMoney2.backgroundColor = UIColor.clearColor()
        buttonMoney3.backgroundColor = UIColor.clearColor()
        buttonAttr1.backgroundColor = UIColor.clearColor()
        buttonAttr2.backgroundColor = UIColor.clearColor()
        
        //Sets background image
        backgroundImage.image = data_s.im_background
        self.buttonMoney1.setBackgroundImage(data_s.im_buttons, forState: .Normal)
        self.buttonMoney2.setBackgroundImage(data_s.im_buttons, forState: .Normal)
        self.buttonMoney3.setBackgroundImage(data_s.im_buttons, forState: .Normal)
        self.buttonAttr1.setBackgroundImage(data_s.im_buttons, forState: .Normal)
        self.buttonAttr2.setBackgroundImage(data_s.im_buttons, forState: .Normal)
        
        updateButtons()
        
        //Start getting money per second
        if(data_s.toAddOverTime)
        {
            var moneyAddTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("addMoney"), userInfo: nil, repeats: true)
            data_s.toAddOverTime = false
        }
        else
        {
            var moneyAddTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateMoney"), userInfo: nil, repeats: true)
        }
    }
    
    func updateButtons()
    {
        switch data_s.timePeriod
        {
        case Game_s.Era.Caveman:    //CAVEMAN
            self.button1Name.text = String(format: "Rock")
            self.BC1.text = String(format: "# %i", data_s.buttonCount1)
            self.button2Name.text = String(format: "Fire")
            self.BC2.text = String(format: "# %i", data_s.buttonCount2)
            self.button3Name.text = String(format: "Animal Skin")
            self.BC3.text = String(format: "# %i", data_s.buttonCount3)
            self.button4Name.text = String(format: "Meat")
            self.BC4.text = String(format: "# %i", data_s.buttonCount4)
            self.button5Name.text = String(format: "Club")
            self.BC5.text = String(format: "# %i", data_s.buttonCount5)
        
            self.BL1.text = String(format: "cost: %i\t\t\t\tgained: %i g/s", data_s.buttonCost1, data_s.buttonCount1 * data_s.moneyGive1)
            self.BL2.text = String(format: "cost: %i\t\t\t\tgained: %i g/s", data_s.buttonCost2, data_s.buttonCount2 * data_s.moneyGive2)
            self.BL3.text = String(format: "cost: %i\t\t\t\tgained: %i g/s", data_s.buttonCost3, data_s.buttonCount3 * data_s.moneyGive3)
            self.BL4.text = String(format: "cost: %i\t\t\t\tgained: %i \(data_s.attrString1)", data_s.buttonCost4, data_s.buttonCount4 * data_s.attrGive1)
            self.BL5.text = String(format: "cost: %i\t\t\t\tgained: %i \(data_s.attrString2)", data_s.buttonCost5, data_s.buttonCount5 * data_s.attrGive2)
        //Add more eras here
            default:
                print("Era not yet implemented")
        }
        
        //Set picture to clicker and buttons
        buttonClicker.setImage(data_s.im_click, forState: .Normal)
        buttonMoney1.setImage(data_s.im_but1, forState: .Normal)
        buttonMoney2.setImage(data_s.im_but2, forState: .Normal)
        buttonMoney3.setImage(data_s.im_but3, forState: .Normal)
        buttonAttr1.setImage(data_s.im_but4, forState: .Normal)
        buttonAttr2.setImage(data_s.im_but5, forState: .Normal)
    }
    
    
    @IBAction func musicOnOff(sender: AnyObject)
    {
        if(data_s.musicIsPlaying)
        {
            data_s.musicFile.pause()
            data_s.musicIsPlaying = false
            buttonAudio.setImage(UIImage(named: "unmute"), forState: .Normal)
        }
        else
        {
            data_s.musicFile.play()
            data_s.musicIsPlaying = true
            buttonAudio.setImage(UIImage(named: "mute"), forState: .Normal)
        }
        
    }

    
    //Called when first button is clicked (money 1 of 3)
    @IBAction func buttonMoney1(sender: AnyObject)
    {
        if(Int(data_s.money) >= data_s.buttonCost1)
        {
            data_s.perSec += data_s.moneyGive1
            data_s.money -= Float64(data_s.buttonCost1)
            data_s.buttonCost1 += Int(Double(data_s.buttonCost1) * 0.2) //increase by 20%
            data_s.buttonCount1 += 1
            updateMoney()
            updateButtons()
        }
    }
    //Called when second button is clicked (money 2 of 3)
    @IBAction func buttonMoney2(sender: AnyObject)
    {
        if(Int(data_s.money) >= data_s.buttonCost2)
        {
            data_s.perSec += data_s.moneyGive2
            data_s.money -= Float64(data_s.buttonCost2)
            data_s.buttonCost2 += Int(Double(data_s.buttonCost2) * 0.2) //increase by 20%
            data_s.buttonCount2 += 1
            updateMoney()
            updateButtons()
        }
    }
    //Called when third button is clicked (money 3 of 3)
    @IBAction func buttonMoney3(sender: AnyObject)
    {
        if(Int(data_s.money) >= data_s.buttonCost3)
        {
            data_s.perSec += data_s.moneyGive3
            data_s.money -= Float64(data_s.buttonCost3)
            data_s.buttonCost3 += Int(Double(data_s.buttonCost3) * 0.2) //increase by 20%
            data_s.buttonCount3 += 1
            updateMoney()
            updateButtons()
        }
    }
    //Clicked when fourth button is clicked (attr 1 of 2)
    @IBAction func buttonAttr1(sender: AnyObject)
    {
        if(Int(data_s.money) >= data_s.buttonCost4)
        {
            let ind = data_s.attrString1.startIndex.advancedBy(0)
            data_s.avatar.increaseStat(data_s.attrGive1, stat: data_s.attrString1[ind])
            
            data_s.money -= Float64(data_s.buttonCost4)
            data_s.buttonCost4 += Int(Double(data_s.buttonCost4) * 0.2) //increase by 20%
            data_s.buttonCount4 += 1
            updateMoney()
            updateButtons()
        }
    }
    //Clicked when fourth button is clicked (attr 2 of 2)
    @IBAction func buttonAttr2(sender: AnyObject)
    {
        if(Int(data_s.money) >= data_s.buttonCost5)
        {
            let ind = data_s.attrString2.startIndex.advancedBy(0)
            data_s.avatar.increaseStat(data_s.attrGive2, stat: data_s.attrString2[ind])

            data_s.money -= Float64(data_s.buttonCost5)
            data_s.buttonCost5 += Int(Double(data_s.buttonCost5) * 0.2) //increase by 20%
            data_s.buttonCount5 += 1
            updateMoney()
            updateButtons()
        }
    }
    //Called every second to update money amount with perSec gain
    func addMoney()
    {
        data_s.money += Float64(data_s.perSec) / 10.0
        updateMoney()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Called when clicking the icon to gain extra gold
    @IBAction func clickIcon(sender: UIButton)
    {
        data_s.money += 1
        updateMoney()
    }
    
    //Called to update what money is shown
    func updateMoney()
    {
        self.labelMoney.text = String(format: "%i gold", Int(data_s.money))
        self.moneyPerSecondLabel.text = String(format: "%i gold/second", data_s.perSec)
        
        if(Int(data_s.money) >= data_s.buttonCost1)
        {
            self.buttonMoney1.enabled = true
        }
        else
        {
            self.buttonMoney1.enabled = false
        }
        if(Int(data_s.money) >= data_s.buttonCost2)
        {
            self.buttonMoney2.enabled = true
        }
        else
        {
            self.buttonMoney2.enabled = false
        }
        if(Int(data_s.money) >= data_s.buttonCost3)
        {
            self.buttonMoney3.enabled = true
        }
        else
        {
            self.buttonMoney3.enabled = false
        }
        if(Int(data_s.money) >= data_s.buttonCost4)
        {
            self.buttonAttr1.enabled = true
        }
        else
        {
            self.buttonAttr1.enabled = false
        }
        if(Int(data_s.money) >= data_s.buttonCost5)
        {
            self.buttonAttr2.enabled = true
        }
        else
        {
            self.buttonAttr2.enabled = false
        }
    }
    
    override func viewDidAppear(animated: Bool)
    {
        let rad:CGFloat = 10.0
        let bordW:CGFloat = 0.25
        
        //Rounded corners to the buttons
        buttonMoney1.layer.cornerRadius = rad
        buttonMoney2.layer.cornerRadius = rad
        buttonMoney3.layer.cornerRadius = rad
        buttonAttr1.layer.cornerRadius = rad
        buttonAttr2.layer.cornerRadius = rad
        
        //Give the buttons a border color and width
        buttonMoney1.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).CGColor
        buttonMoney1.layer.borderWidth = bordW
        buttonMoney2.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).CGColor
        buttonMoney2.layer.borderWidth = bordW
        buttonMoney3.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).CGColor
        buttonMoney3.layer.borderWidth = bordW
        buttonAttr1.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).CGColor
        buttonAttr1.layer.borderWidth = bordW
        buttonAttr2.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).CGColor
        buttonAttr2.layer.borderWidth = bordW
        
        //Add these attributes to the UI
        buttonMoney1.layer.masksToBounds = true
        buttonMoney2.layer.masksToBounds = true
        buttonMoney3.layer.masksToBounds = true
        buttonAttr1.layer.masksToBounds = true
        buttonAttr2.layer.masksToBounds = true
    }
    
    //Changes the animation between views to the ones created
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "toCoinDrop")
        {
            transitionManager.changeDir(TransitionManager.Direction.up)
        }
        else if(segue.identifier == "toGameOfChance")
        {
            transitionManager.changeDir(TransitionManager.Direction.left)
        }
        else if(segue.identifier == "toBattleView")
        {
            transitionManager.changeDir(TransitionManager.Direction.right)
        }
        else if(segue.identifier == "toAvatarStats")
        {
            transitionManager.changeDir(TransitionManager.Direction.down)
        }
        
        let toViewController = segue.destinationViewController 
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        toViewController.transitioningDelegate = transitionManager
        
    }
  
}

