//
//  AchievementsViewController.swift
//  Through Time
//
//  Created by Gregory Johnson on 3/10/15.
//  Copyright (c) 2015 Gregory Johnson. All rights reserved.
//

import UIKit

class AchievementsViewController: UIViewController
{
    let transitionManager = TransitionManager(direction: TransitionManager.Direction.up)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "toAvatarStats")
        {
            transitionManager.changeDir(TransitionManager.Direction.left)
        }
        else if(segue.identifier == "toBattleView")
        {
            transitionManager.changeDir(TransitionManager.Direction.up)
        }
        
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController 
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        toViewController.transitioningDelegate = self.transitionManager
        navigationController?.popViewControllerAnimated(true)
    }
}