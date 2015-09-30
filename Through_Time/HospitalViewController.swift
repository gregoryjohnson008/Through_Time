//
//  HospitalViewController.swift
//  Through_Time
//
//  Created by Greg Johnson on 9/30/15.
//  Copyright © 2015 Gregory Johnson. All rights reserved.
//

import UIKit

class HospitalViewController: UIViewController
{
    
    let transitionManager = TransitionManager(direction: TransitionManager.Direction.down)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "toBattleView")
        {
            transitionManager.changeDir(TransitionManager.Direction.down)
        }
        else if(segue.identifier == "toCoinDrop")
        {
            transitionManager.changeDir(TransitionManager.Direction.left)
        }
        
        let toViewController = segue.destinationViewController
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        toViewController.transitioningDelegate = transitionManager
    }
}