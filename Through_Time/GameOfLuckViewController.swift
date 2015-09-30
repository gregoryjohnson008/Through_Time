//
//  GameOfLuck.swift
//  Through Time
//
//  Created by Gregory Johnson on 3/12/15.
//  Copyright (c) 2015 Gregory Johnson. All rights reserved.
//

import UIKit

class GameOfLuckViewController: UIViewController
{
    
    let transitionManager = TransitionManager(direction: TransitionManager.Direction.right)
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var moneyLabel: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    let image = UIImage(named: "chest_closed") as UIImage?
    let open = UIImage(named: "chest_open") as UIImage?
    let coin = UIImage(named: "coin") as UIImage?
    let diamond = UIImage(named: "diamond") as UIImage?
    var buttonDouble:Int = 0
    var buttonKeep:Int = 0
    var playGame:Bool = true
    var canPress:Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        directionsLabel.text = "To start the game hit the \"Play Game\" button"
        button1.setTitle("", forState: UIControlState.Normal)
        button2.setTitle("", forState: UIControlState.Normal)
        button3.setTitle("", forState: UIControlState.Normal)
        
        _ = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateMoney"), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateMoney()
    {
        self.moneyLabel.text = String(format: "%i gold", Int(data_s.money))
    }
    
    @IBAction func playGame(sender: AnyObject)
    {
        if(playGame)
        {
            var i = 0
            buttonDouble = Int(arc4random_uniform(3)) + 1
            repeat
            {
                buttonKeep = Int(arc4random_uniform(3)) + 1
                i = i + 1
            }while(buttonKeep == buttonDouble && i < 5)
        
            if(i == 5)
            {
                buttonKeep = (buttonDouble % 3) + 1
            }
        
            setupButtons()
            
            
            directionsLabel.text = "Find the diamond to double your gold, find the coin to keep your current gold, find the empty chest to lose all your gold."
            
            buttonPlay.setTitle("Playing...", forState: UIControlState.Normal)
            playGame = false
        }
    }
    
    func setupButtons()
    {
        button1.setBackgroundImage(image, forState: UIControlState.Normal)
        button1.setTitle("", forState: UIControlState.Normal)
        
        button2.setBackgroundImage(image, forState: UIControlState.Normal)
        button2.setTitle("", forState: UIControlState.Normal)
        
        button3.setBackgroundImage(image, forState: UIControlState.Normal)
        button3.setTitle("", forState: UIControlState.Normal)
        
        image1.image = UIImage(contentsOfFile: "transparent")
        image2.image = UIImage(contentsOfFile: "transparent")
        image3.image = UIImage(contentsOfFile: "transparent")
        
        canPress = true
    }
    
    
    @IBAction func pressButton1(sender: AnyObject)
    {
        if(canPress)
        {
            canPress = false
            if(buttonDouble == 1)
            {
                data_s.money = data_s.money * 2
                directionsLabel.text = "Congratulations! You just doubled your gold!"
            }
            else if(buttonKeep == 1)
            {
                directionsLabel.text = "You get to keep the money you have."
            }
            else
            {
                data_s.money = 0
                directionsLabel.text = "Oh no. Looks like you lost all of you gold. Better luck next time."
            }
            showContents()
            playGame = true
            buttonPlay.setTitle("Play New Game", forState: UIControlState.Normal)
        }
    }
    @IBAction func pressButton2(sender: AnyObject)
    {
        if(canPress)
        {
            canPress = false
            if(buttonDouble == 2)
            {
                data_s.money = data_s.money * 2
                directionsLabel.text = "Congratulations! You just doubled your gold!"
            }
            else if(buttonKeep == 2)
            {
                directionsLabel.text = "You get to keep the money you have."
            }
            else
            {
                data_s.money = 0
                directionsLabel.text = "Oh no. Looks like you lost all of you gold. Better luck next time."
            }
            showContents()
            playGame = true
            buttonPlay.setTitle("Play New Game", forState: UIControlState.Normal)
        }
    }
    @IBAction func pressButton3(sender: AnyObject)
    {
        if(canPress)
        {
            canPress = false
            if(buttonDouble == 3)
            {
                data_s.money = data_s.money * 2
                directionsLabel.text = "Congratulations! You just doubled your gold!"
            }
            else if(buttonKeep == 3)
            {
                directionsLabel.text = "You get to keep the money you have."
            }
            else
            {
                data_s.money = 0
                directionsLabel.text = "Oh no. Looks like you lost all of you gold. Better luck next time."
            }
            showContents()
            playGame = true
            buttonPlay.setTitle("Play New Game", forState: UIControlState.Normal)
        }
    }
    
    func showContents()
    {
        button1.setBackgroundImage(open, forState: UIControlState.Normal)
        button2.setBackgroundImage(open, forState: UIControlState.Normal)
        button3.setBackgroundImage(open, forState: UIControlState.Normal)
        
        switch buttonDouble
        {
        case 1:
            image1.image = diamond
        case 2:
            image2.image = diamond
        case 3:
            image3.image = diamond
        default:
            print("buttonDouble not set correctly")
        }
        
        switch buttonKeep
        {
        case 1:
            image1.image = coin
        case 2:
            image2.image = coin
        case 3:
            image3.image = coin
        default:
            print("buttonKeep not set correctly")
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
    
        if(segue.identifier == "toMain")
        {
            transitionManager.changeDir(TransitionManager.Direction.right)
        }
        
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController 
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        toViewController.transitioningDelegate = self.transitionManager
        navigationController?.popViewControllerAnimated(true)
    }
}