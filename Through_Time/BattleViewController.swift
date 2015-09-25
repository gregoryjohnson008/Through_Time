//
//  BattleViewController.swift
//  Through Time
//
//  Created by Gregory Johnson on 7/25/15.
//  Copyright (c) 2015 Gregory Johnson. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController
{
    //Characters in battle
    @IBOutlet weak var goodGuy: UIView!
    @IBOutlet weak var badGuy: UIView!
    //Health Full
    @IBOutlet weak var healthFull_goodGuy: UIImageView!
    @IBOutlet weak var healthFull_badGuy: UIImageView!
    //Health Empty
    @IBOutlet weak var healthEmpty_goodGuy: UIImageView!
    @IBOutlet weak var healthEmpty_badGuy: UIImageView!
    //Health Value Text
    @IBOutlet weak var healthText_goodGuy: UILabel!
    @IBOutlet weak var healthText_badGuy: UILabel!
    //Damage value text
    @IBOutlet weak var hitGoodGuy: UILabel!
    @IBOutlet weak var hitBadGuy: UILabel!
    //Position to move to when attacking
    @IBOutlet weak var gAttachPos: UIView!
    @IBOutlet weak var bAttackPos: UIView!
    //UI elements to control battle
    @IBOutlet weak var attackButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var buttonContainer: UIView!
    
    let transitionManager = TransitionManager(direction: TransitionManager.Direction.down)
    
    var turn:Bool = true //true = goodGuy, false = badGuy
    var speed = 1.0 //speed of the battle
    
    //TEMPORARY---------------------------
    var badCurr_health:Int = 30
    var badMax_health:Int = 30
    var badAttack:Int = 5
    //------------------------------------
    
    var textBadCurrHealth:Int = 30                              //Needed in order to print the correct health value for the bad guy
    var textGoodCurrHealth:Int = data_s.avatar.currHealth       //Needed in order to print the correct health value for the good guy
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Set background image
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "cave_background")?.drawInRect(self.view.bounds)
        let backImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: backImage)
        
        //Set up health bar image and text
        self.healthFull_goodGuy.transform = CGAffineTransformMakeScale(max(0.001, CGFloat(data_s.avatar.currHealth) / CGFloat(data_s.avatar.maxHealth)), 1.0)
        healthText_goodGuy.text = "\(data_s.avatar.currHealth) / \(data_s.avatar.maxHealth)"
        healthText_badGuy.text = "\(badCurr_health) / \(badMax_health)"
        
        //Make damage labels transparent
        self.hitGoodGuy.alpha = 0
        self.hitBadGuy.alpha = 0
        
        //Put character images in place
        UIGraphicsBeginImageContext(goodGuy.frame.size)
        UIImage(named: "goodguy_face")?.drawInRect(goodGuy.bounds)
        let gImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIGraphicsBeginImageContext(badGuy.frame.size)
        UIImage(named: "badguy_face")?.drawInRect(badGuy.bounds)
        let bImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        goodGuy.backgroundColor = UIColor(patternImage: gImage)
        badGuy.backgroundColor = UIColor(patternImage: bImage)
        
        //Container
        buttonContainer.layer.cornerRadius = 50
        
    }

    @IBAction func indexChanged(sender: UISegmentedControl)
    {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            speed = 1.0
        case 1:
            speed = 0.5
        default:
            break
        }
    }
    
    @IBAction func startBattle(sender: AnyObject)
    {
        /*
        * TODO:
        *       -Generate attack values for hero based on stats
        *       -Generate stats for enemies depending on current time era
        *       -Damage display over character heads to show how much they were damaged
        *       -Ability to move through battles up until boss
        *       -What happens if you die?
        */
        
        let gFrame = self.goodGuy.frame
        let bFrame = self.badGuy.frame
        var gDamage:Int = 0
        var bDamage:Int = 0
        attackButton.enabled = false
        
        //GOOD GUY MOVES--------------------------------------------------------------
        
        //Do damage
        gDamage = data_s.avatar.getDamage()
        badCurr_health =  max(0, badCurr_health - gDamage) //need to have enemy class to pass values around with
        
        print("Good guy damage: \(gDamage)")
        //1. Good guy goes toward bad guy
        UIView.animateWithDuration(speed, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            var nextFrame = self.goodGuy.frame
            nextFrame.origin.x = self.gAttachPos.frame.origin.x
            self.goodGuy.frame = nextFrame
            
            }, completion: { (finished: Bool) -> Void in
                self.hitBadGuy.text = "\(gDamage)"
        })
        
        //2. Health bar changes size
        UIView.animateWithDuration(0.5, delay: speed, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            
            self.healthFull_badGuy.transform = CGAffineTransformMakeScale(max(0.001, CGFloat(self.badCurr_health) / CGFloat(self.badMax_health)), 1.0)
            
            }, completion: { (finished: Bool) -> Void in
                self.textBadCurrHealth = max(0, self.textBadCurrHealth - gDamage)
                self.healthText_badGuy.text = "\(self.textBadCurrHealth) / \(self.badMax_health)"
        })
        
        //3. Damage value is shown
        UIView.animateWithDuration(0.5, delay: speed, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            var hitFrame = self.hitBadGuy.frame
            hitFrame.origin.y -= 10
            self.hitBadGuy.frame = hitFrame
            self.hitBadGuy.alpha = 1
            
            }, completion: { (finished: Bool) -> Void in
                self.hitBadGuy.frame.origin.y += 10
                self.hitBadGuy.alpha = 0
        })
        
        
        //4. good guy goes back to starting position
        UIView.animateWithDuration(speed, delay: speed, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            var nextFrame = self.goodGuy.frame
            nextFrame.origin.x = gFrame.origin.x
            self.goodGuy.frame = nextFrame
            
            }, completion: { (finished: Bool) -> Void in
                print("Moved back")
        })
        //----------------------------------------------------------------------------
        //BAD GUY MOVES---------------------------------------------------------------
        if(badCurr_health > 0)
        {
            //Do damage
            let taken = data_s.avatar.takeDamage(badAttack)
            bDamage = taken.damage //badAttack to be replaced by generated value
            print("Bad guy damage: \(bDamage)")
            
            //5. bad guy goes toward good guy
            UIView.animateWithDuration(speed, delay: 2.0*speed, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                var nextFrame = self.badGuy.frame
                nextFrame.origin.x = self.bAttackPos.frame.origin.x
                self.badGuy.frame = nextFrame
                
                }, completion: { (finished: Bool) -> Void in
                    self.hitGoodGuy.text = "\(bDamage)"
            })
            
            //6. Health bar changes size
            UIView.animateWithDuration(0.5, delay: 3.0*speed, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                
                self.healthFull_goodGuy.transform = CGAffineTransformMakeScale(max(0.001, CGFloat(data_s.avatar.currHealth) / CGFloat(data_s.avatar.maxHealth)), 1.0)
                
                }, completion: { (finished: Bool) -> Void in
                    self.textGoodCurrHealth = max(0, self.textGoodCurrHealth - bDamage)
                    self.healthText_goodGuy.text = "\(self.textGoodCurrHealth) / \(data_s.avatar.maxHealth)"
            })
            
            //7. Damage value is shown
            UIView.animateWithDuration(0.5, delay: 3.0*speed, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                
                var hitFrame = self.hitGoodGuy.frame
                hitFrame.origin.y -= 10
                self.hitGoodGuy.frame = hitFrame
                self.hitGoodGuy.alpha = 1
                
                }, completion: { (finished: Bool) -> Void in
                    self.hitGoodGuy.frame.origin.y += 10
                    self.hitGoodGuy.alpha = 0
            })
            
            //8. bad guy goes back to starting position
            UIView.animateWithDuration(speed, delay: 3.0*speed, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                var nextFrame = self.badGuy.frame
                nextFrame.origin.x = bFrame.origin.x
                self.badGuy.frame = nextFrame
                
                }, completion: { (finished: Bool) -> Void in
                    print("Moved back")
                    self.attackButton.enabled = true
            })
            //-----------------------------------------------------------------------------
            
            if(!taken.alive)
            {
                //player has died
                
            }
            
        }
        else
        {
            //need to generate new enemy or if this was the boss change to allow progression to next era
        }
        

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "toMainView")
        {
            transitionManager.changeDir(TransitionManager.Direction.left)
        }
        else if(segue.identifier == "toAchievements")
        {
            transitionManager.changeDir(TransitionManager.Direction.down)
        }
        
        let toViewController = segue.destinationViewController 
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        toViewController.transitioningDelegate = transitionManager
    }
    
    
}