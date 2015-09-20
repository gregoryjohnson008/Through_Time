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
    
    @IBOutlet weak var goodGuy: UIImageView!
    @IBOutlet weak var badGuy: UIImageView!
    
    @IBOutlet weak var healthFull_goodGuy: UIImageView!
    @IBOutlet weak var healthFull_badGuy: UIImageView!
    @IBOutlet weak var healthEmpty_goodGuy: UIImageView!
    @IBOutlet weak var healthEmpty_badGuy: UIImageView!
    @IBOutlet weak var healthText_goodGuy: UILabel!
    @IBOutlet weak var healthText_badGuy: UILabel!
    
    @IBOutlet weak var hitGoodGuy: UILabel!
    @IBOutlet weak var hitBadGuy: UILabel!
    
    let transitionManager = TransitionManager(direction: TransitionManager.Direction.down)
    
    //TEMPORARY
    var badCurr_health:Int = 30
    var badMax_health:Int = 30
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        healthText_goodGuy.text = "\(data_s.avatar.currHealth) / \(data_s.avatar.maxHealth)"
        healthText_badGuy.text = "\(badCurr_health) / \(badMax_health)"
        
        /*TODO
        * set images
        */
        
        hitGoodGuy.alpha = 0
        hitBadGuy.alpha = 0
        
        // startBattle()
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startBattle()
    {
        hitGoodGuy.alpha = 0.5
        hitBadGuy.alpha = 0.5
        
        //animate guys
    }
    
    func moveView(view:UIView, toPoint destination:CGPoint)
    {
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {view.center = destination}, completion: nil)
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