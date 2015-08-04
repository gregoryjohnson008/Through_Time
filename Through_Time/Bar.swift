//
//  Bar.swift
//  Through Time
//
//  Created by Gregory Johnson on 3/26/15.
//  Copyright (c) 2015 Gregory Johnson. All rights reserved.
//

import UIKit
import SpriteKit

class Bar: SKSpriteNode
{
    required init(coder aDecoder:NSCoder)
    {
        fatalError("Init(coder:) has not been implemented")
    }
    
    init(imageNamed:String)
    {
        let imageTexture = SKTexture(imageNamed: imageNamed)
        super.init(texture: imageTexture, color:nil, size: imageTexture.size())
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: imageTexture.size().width/2)//makes more sense to make coin a circle
        self.physicsBody?.dynamic = false //give physics properties: starting as false
        self.physicsBody?.mass = 1
    }
    
    func makeBodyDynamic()
    {
        self.physicsBody?.dynamic = true
    }
}
