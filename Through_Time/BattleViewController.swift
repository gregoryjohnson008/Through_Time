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
    
    @IBOutlet weak var goodGuy: UIView!
    @IBOutlet weak var badGuy: UIView!
    
    @IBOutlet weak var healthFull_goodGuy: UIImageView!
    @IBOutlet weak var healthFull_badGuy: UIImageView!
    @IBOutlet weak var healthEmpty_goodGuy: UIImageView!
    @IBOutlet weak var healthEmpty_badGuy: UIImageView!
    @IBOutlet weak var healthText_goodGuy: UILabel!
    @IBOutlet weak var healthText_badGuy: UILabel!
    
    @IBOutlet weak var gAttachPos: UIView!
    @IBOutlet weak var bAttackPos: UIView!
    
    @IBOutlet weak var attackButton: UIButton!
    
    let transitionManager = TransitionManager(direction: TransitionManager.Direction.down)
    
    var turn:Bool = true //true = goodGuy, false = badGuy
    var speed = 2.0 //speed of the battle
    
    //TEMPORARY---------------------------
    var badCurr_health:Int = 30
    var badMax_health:Int = 30
    var badAttack:Int = 10
    var goodAttack:Int = 10
    //------------------------------------
    
    var textBadCurrHealth:Int = 30                              //Needed in order to print the correct health value for the bad guy
    var textGoodCurrHealth:Int = data_s.avatar.currHealth       //Needed in order to print the correct health value for the good guy
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        healthText_goodGuy.text = "\(data_s.avatar.currHealth) / \(data_s.avatar.maxHealth)"
        healthText_badGuy.text = "\(badCurr_health) / \(badMax_health)"
        
        /*TODO
        * set images
        */
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
        
        
     //   hitGoodGuy.alpha = 0
     //   hitBadGuy.alpha = 0
        
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
        attackButton.enabled = false
        
        //1. good guy goes toward bad guy
        UIView.animateWithDuration(speed, delay: 1.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            var nextFrame = self.goodGuy.frame
            nextFrame.origin.x = self.gAttachPos.frame.origin.x
            self.goodGuy.frame = nextFrame
            
            }, completion: { (finished: Bool) -> Void in
                print("Move forward")
        })
        
        badCurr_health -= goodAttack //number to be replaced by generated value
        
        //2. Health bar changes size
        UIView.animateWithDuration(0.5, delay: speed + 1.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            
            self.healthFull_badGuy.transform = CGAffineTransformMakeScale(max(0.001, CGFloat(self.badCurr_health) / CGFloat(self.badMax_health)), 1.0)
            
            }, completion: { (finished: Bool) -> Void in
                self.textBadCurrHealth -= self.goodAttack
                self.healthText_badGuy.text = "\(self.textBadCurrHealth) / \(self.badMax_health)"
                print("width: \(self.healthText_badGuy.frame.size.width)")
        })
        
        
        //3. good guy goes back to starting position
        UIView.animateWithDuration(speed, delay: speed + 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            var nextFrame = self.goodGuy.frame
            nextFrame.origin.x = gFrame.origin.x
            self.goodGuy.frame = nextFrame
            
            }, completion: { (finished: Bool) -> Void in
                print("Moved back")
        })
        
        if(badCurr_health > 0)
        {
            //4. bad guy goes toward bad guy
            UIView.animateWithDuration(speed, delay: 1.0 + 2.0*speed, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                var nextFrame = self.badGuy.frame
                nextFrame.origin.x = self.bAttackPos.frame.origin.x
                self.badGuy.frame = nextFrame
                
                }, completion: { (finished: Bool) -> Void in
                    print("Move forward")
            })
            
            data_s.avatar.currHealth -= badAttack //number to be replaced by generated value
            
            //5. Health bar changes size
            UIView.animateWithDuration(0.5, delay: 3.0*speed + 1.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                
                self.healthFull_goodGuy.transform = CGAffineTransformMakeScale(max(0.001, CGFloat(data_s.avatar.currHealth) / CGFloat(data_s.avatar.maxHealth)), 1.0)
                
                }, completion: { (finished: Bool) -> Void in
                    self.textGoodCurrHealth -= self.badAttack
                    self.healthText_goodGuy.text = "\(self.textGoodCurrHealth) / \(data_s.avatar.maxHealth)"
                    print("width: \(self.healthText_goodGuy.frame.size.width)")
            })
            
            
            //6. good guy goes back to starting position
            UIView.animateWithDuration(speed, delay: 3.0*speed + 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                var nextFrame = self.badGuy.frame
                nextFrame.origin.x = bFrame.origin.x
                self.badGuy.frame = nextFrame
                
                }, completion: { (finished: Bool) -> Void in
                    print("Moved back")
                    self.attackButton.enabled = true
            })
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
    
    func moveView(thisView:UIView, toMove:CGFloat)
    {
        UIView.animateWithDuration(3.0, delay: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            var topFrame = thisView.frame
            topFrame.origin.x += toMove
            
            thisView.frame = topFrame
            }, completion: {
                finished in
                print("Moved")
        })
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