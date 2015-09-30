//
//  coinDropViewController.swift
//  Through Time
//
//  Created by Gregory Johnson on 3/11/15.
//  Copyright (c) 2015 Gregory Johnson. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController
{
    
    let transitionManager = TransitionManager(direction: TransitionManager.Direction.down)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let scene = GameScene.unarchiveFromFile("coinDropScene") as? GameScene {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        let skView = self.view as! SKView
        let scale:CGFloat = UIScreen.mainScreen().scale;
        let size = CGSizeMake(skView.frame.size.width*scale, skView.frame.size.height*scale)
        if ((skView.scene) != nil) {
            if let scene = GameScene.unarchiveFromFile("coinDropScene") as? GameScene {
                // Configure the view.
                skView.showsFPS = true
                skView.showsNodeCount = true
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .AspectFill
                scene.size = size
                skView.presentScene(scene)
            }
        }
        else {
            skView.scene?.size = size;
        }
    }

    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.Portrait
        } else {
            return UIInterfaceOrientationMask.All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "toMain")
        {
            transitionManager.changeDir(TransitionManager.Direction.down)
        }
        else if(segue.identifier == "toHospital")
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