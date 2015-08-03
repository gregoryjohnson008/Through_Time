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
    
    let transitionManager = TransitionManager(direction: TransitionManager.Direction.down)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
        
        let toViewController = segue.destinationViewController as! UIViewController
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        toViewController.transitioningDelegate = transitionManager
        
    }
}