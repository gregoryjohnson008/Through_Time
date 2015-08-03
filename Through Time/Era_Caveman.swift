//
//  Era_Caveman.swift
//  Through Time
//
//  Created by Gregory Johnson on 3/10/15.
//  Copyright (c) 2015 Gregory Johnson. All rights reserved.
//

import UIKit

class Era_Caveman: EraSuperClass
{
    override init()
    {
        super.init()
        
        data_s.im_click = UIImage(named: "cave_egg")
        data_s.im_but1 = UIImage(named: "cave_rock")
        data_s.im_but2 = UIImage(named: "cave_fire")
        data_s.im_but3 = UIImage(named: "cave_animalSkin")
        data_s.im_but4 = UIImage(named: "cave_meat")
        data_s.im_but5 = UIImage(named: "cave_club")
        
        data_s.im_background = UIImage(named:"cave_background")
        
        
        data_s.moneyGive1 = 1
        data_s.moneyGive2 = 5
        data_s.moneyGive3 = 20
        
        data_s.attrGive1 = 5
        data_s.attrGive2 = 2
        
        data_s.attrString1 = "health"
        data_s.attrString2 = "attack"
        
        data_s.buttonCost1 = 10
        data_s.buttonCost2 = 45
        data_s.buttonCost3 = 150
        data_s.buttonCost4 = 700
        data_s.buttonCost5 = 1000
    }
}
