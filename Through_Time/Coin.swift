//
//  Coin.swift
//  Through Time
//
//  Created by Gregory Johnson on 3/11/15.
//  Copyright (c) 2015 Gregory Johnson. All rights reserved.
//

import UIKit
import SpriteKit

class Coin: SKSpriteNode
{
    var imSize:CGSize
    required init(coder aDecoder:NSCoder)
    {
        fatalError("Init(coder:) has not been implemented")
    }

    init(imageNamed:String)
    {
        let imageTexture = SKTexture(imageNamed: imageNamed)
        imSize = CGSize(width: imageTexture.size().width*data_s.mult, height: imageTexture.size().height*data_s.mult)
        super.init(texture: imageTexture, color: UIColor.yellowColor(), size: imSize)

        self.physicsBody = SKPhysicsBody(circleOfRadius: imSize.width/2)//makes more sense to make coin a circle
        self.physicsBody?.dynamic = false //give physics properties: starting as false
        self.physicsBody?.restitution = 0.5
        self.physicsBody?.mass = 1
    }
    
    func makeBodyDynamic()
    {
        self.physicsBody?.dynamic = true
    }
}