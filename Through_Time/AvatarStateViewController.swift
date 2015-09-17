//
//  AvatarStatViewController.swift
//  Through Time
//
//  Created by Gregory Johnson on 3/1/15.
//  Copyright (c) 2015 Gregory Johnson. All rights reserved.
//

import UIKit

class AvatarStateViewController: UIViewController
{
    @IBOutlet weak var labelHealth: UILabel!
    @IBOutlet weak var labelAttack: UILabel!
    @IBOutlet weak var labelDefense: UILabel!
    @IBOutlet weak var labelSpeed: UILabel!
    
    let transitionManager = TransitionManager(direction: TransitionManager.Direction.up)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.labelHealth.text = String(format: "Health: %i / %i", data_s.avatar.currHealth, data_s.avatar.maxHealth)
        
        self.labelAttack.text = String(format: "Attack: %i - %i", data_s.avatar.minAttack, data_s.avatar.maxAttack)
        
        self.labelDefense.text = String(format: "Defense: %i", data_s.avatar.defense)
        
        self.labelSpeed.text = String(format: "Speed: %i", data_s.avatar.speed)
        
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "toAchievements")
        {
            transitionManager.changeDir(TransitionManager.Direction.right)
        }
        else if(segue.identifier == "toMain")
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