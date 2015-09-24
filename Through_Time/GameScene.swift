//
//  coinDrop.swift
//  Through Time
//
//  Created by Gregory Johnson on 3/11/15.
//  Copyright (c) 2015 Gregory Johnson. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene
{
    var sceneWidth:CGFloat = 0
    var sceneHeight:CGFloat = 0
    
    var coinNode:Coin?
    
    var pegNode:[Peg] = [Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg"), Peg(imageNamed: "peg")]
    
    var goalNode:[Bar] = [Bar(imageNamed: "bar"), Bar(imageNamed: "bar")]
    var yPosGoal:CGFloat = -20
    var distBetween:Int = 70*Int(data_s.mult) //distance between goal posts
    
    var falling:Bool = false
    var coinStartX:CGFloat = 0
    var coinStartY:CGFloat = 0
    
    var countDown:Bool = false
    
    var time = SKLabelNode(fontNamed: "Chalkduster")
    var counting:NSTimer? = nil
    var nums:[Float] = [2.0, 1.9, 1.8, 1.7, 1.6, 1.5, 1.4, 1.3, 1.2, 1.1, 1.0, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.0]
    var ind:Int = 0
    
    override func didMoveToView(view: SKView)
    {
        print("Called")
        
        /*Clear the view
        view.subviews.map({$0.removeFromSuperview()})*/
        
        //Set up variables for scene width and height
        sceneWidth = self.view!.scene!.size.width
        sceneHeight = self.view!.scene!.size.height
        
        //Set up coin start position based on screen
        coinStartX = sceneWidth/2.0
        coinStartY = sceneHeight - 100
        
        coinNode = Coin(imageNamed: "coin")
        coinNode!.position = CGPointMake(coinStartX , coinStartY)
        
        //Set up beginning time label
        time.text = "\(nums[0]) second(s)"
        time.fontSize = 24
        time.position = CGPoint(x:sceneWidth/2.0, y: sceneHeight - 50)
        self.addChild(time)
        
        //Set up labels for displaying directions
        let myLabel1 = SKLabelNode(fontNamed: "Chalkduster")
        let myLabel2 = SKLabelNode(fontNamed: "Chalkduster")
        myLabel1.text = "Try to get the coin"
        myLabel2.text = "to land in the goal"
        myLabel1.fontSize = 28
        myLabel2.fontSize = 28
        myLabel1.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        myLabel2.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 40);
        
        var redLine:[SKSpriteNode] = [SKSpriteNode(imageNamed: "redDropLine"), SKSpriteNode(imageNamed: "redDropLine"), SKSpriteNode(imageNamed: "redDropLine"), SKSpriteNode(imageNamed: "redDropLine"), SKSpriteNode(imageNamed: "redDropLine"), SKSpriteNode(imageNamed: "redDropLine"), SKSpriteNode(imageNamed: "redDropLine"), SKSpriteNode(imageNamed: "redDropLine"), SKSpriteNode(imageNamed: "redDropLine"), SKSpriteNode(imageNamed: "redDropLine"), SKSpriteNode(imageNamed: "redDropLine"), SKSpriteNode(imageNamed: "redDropLine"), SKSpriteNode(imageNamed: "redDropLine"), SKSpriteNode(imageNamed: "redDropLine"), SKSpriteNode(imageNamed: "redDropLine"), SKSpriteNode(imageNamed: "redDropLine")]
        
        let amount = Int(sceneWidth/redLine[0].size.width) + 1 //Add one to ensure it convers completely across
        print("amount: \(amount)")
        for(var i = 0; i <= amount; i++)
        {
            redLine[i].position = CGPoint(x: CGFloat(i * Int(redLine[0].size.width)), y: coinStartY - coinNode!.size.height/2)
            self.addChild(redLine[i])
        }
        
        //Creat SKPhysicsBody (borders for collision)
        let borders:[SKPhysicsBody] = [SKPhysicsBody(edgeFromPoint: CGPoint(x: 0, y: sceneHeight), toPoint: CGPoint(x: 0, y: 0)), SKPhysicsBody(edgeFromPoint: CGPoint(x: sceneWidth, y: sceneHeight), toPoint: CGPoint(x: sceneWidth, y: 0))]
        let fullBorder = SKPhysicsBody(bodies: borders)
        
        //Set the friction of that physicsBody to 0
        fullBorder.friction = 1
        fullBorder.dynamic = false
        fullBorder.mass = 1
        fullBorder.restitution = 0.5

        //Set physicsBody of scene to borderBody
        self.physicsBody = fullBorder
        
        /*Setup scene here */
        setPegsOne()
        
        setGoalPos(goalNode, space: distBetween)
        
        self.addChild(myLabel1)
        self.addChild(myLabel2)
        self.addChild(coinNode!) //may not be able to add without a position
        self.addChild(goalNode[0])
        self.addChild(goalNode[1])
    }
    
    func setPegsOne()
    {
        /*
            *   *   *
              *   *
            *   *   *
              *   *
            *   *   *
              *   *
            *   *   *
              *   *
            *   *   *
        
            numLineOnePegs = 3
            numLineTwoPegs = 2
            sceneWidth = 20 * pegWidth
            sceneHeight = 35.5 * pegHeight
        */
        
        let totalPegs:Int = 24
        let pegJump:CGFloat = sceneHeight*0.175
        
        var xPos:CGFloat = 0
        var xMult:[CGFloat] = [0.2, 0.5, 0.8, 0.35, 0.65] //multipliers for x position of peg
        
        for(var pegIndex = 0, distDown = sceneHeight*0.10, count = 1; pegIndex < totalPegs - 1; pegIndex++, count++)
        {
            if(count <= 3) //lines with 3 pegs
            {
                xPos = sceneWidth*xMult[count-1]
                pegNode[pegIndex].position = CGPointMake(xPos, distDown)
            }
            else if(count <= 5) //lines with 2 pegs
            {
                xPos = sceneWidth*xMult[count-1]
                pegNode[pegIndex].position = CGPointMake(xPos, distDown + (pegJump)/2)
            }
            
            if(count == 5)
            {
                count = 0
                distDown += pegJump
            }
            self.addChild(pegNode[pegIndex])
        }
    }
    
    func setGoalPos(goal:[SKSpriteNode], space:Int)
    {
        let xLeft:Int = Int(arc4random_uniform(UInt32(sceneWidth) - UInt32(sceneWidth*0.2) - UInt32(sceneWidth*0.3))) + Int(sceneWidth*0.2)
        let xRight:Int = xLeft + space
        
        goalNode[0].position = CGPointMake(CGFloat(xLeft), yPosGoal)
        goalNode[1].position = CGPointMake(CGFloat(xRight), yPosGoal)
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        
        /*Called when a touch begins */
        for touch: AnyObject in touches
        {
            let location = touch.locationInNode(self)
            if(!falling)
            {
                if(coinNode != nil)
                {
                    coinNode!.position.x = location.x //need to this to only change x position: setting coin horizontally
                    coinNode!.position.y = coinStartY
                    coinNode!.physicsBody?.velocity = CGVectorMake(0,0)
                    coinNode!.physicsBody?.dynamic = false
                    
                    if(!countDown)
                    {
                        time.text = "2.0 second(s)"
                        ind = 0
                        counting = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("subTime"), userInfo: nil, repeats: true)
                        self.countDown = true
                    }
                    
                    let waitAction = SKAction.waitForDuration(2)
            
                    coinNode!.runAction(waitAction, completion:
                        {
                
                            self.someEvent() //called two seconds after the touch. Gives the node its physics properties allowing it to fall
                            self.falling = true
                
                        }
                                    )
                }
                else
                {
                    print("Coin was never created")
                }
            }
        }
        
    }
    
    func someEvent()
    {
        coinNode!.makeBodyDynamic()
        print("The wait is up")
    }
    func subTime()
    {
        if(ind < nums.count)
        {
            time.text = "\(nums[ind]) second(s)"
            ind += 1
        }
    }
    
    override func update(currentTime: CFTimeInterval)
    {
        /*Called before each frame is rendered */
        if(coinNode!.position.y < 0 && self.falling != false)
        {
            /*Coin get into goal*/
            if(goalNode[0].position.x < coinNode!.position.x && goalNode[1].position.x > coinNode!.position.x)
            {
                time.text = "Got it in"
                self.setGoalPos(goalNode, space: distBetween)
                print("reset goal")
            }
            self.falling = false
            if(counting != nil)
            {
                counting!.invalidate()
                counting = nil
            }
            self.countDown = false
        }
        
    }
}