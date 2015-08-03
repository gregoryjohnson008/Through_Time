//
//  structureForData.swift
//  Through Time
//
//  Created by Gregory Johnson on 3/1/15.
//  Copyright (c) 2015 Gregory Johnson. All rights reserved.
//

import UIKit

//holds all data to be used in different views
struct Game_s
{
    var money:Int = 0
    var avatar:Avatar = Avatar()
    enum Era
    {
        case Caveman
        case AncientEgypt
        case Roman
        case ChineseDynasty
        case Medieval
        case WW1
        case WW2
        case Present
        case Future
    }
    
    var im_click:UIImage? = nil
    var im_but1:UIImage? = nil
    var im_but2:UIImage? = nil
    var im_but3:UIImage? = nil
    var im_but4:UIImage? = nil
    var im_but5:UIImage? = nil
    var im_background:UIImage? = nil
    
    var musicPlaying:Bool = false
    
    var timePeriod:Era = Era.Caveman
    
    var perSec:Int = 1
    
    var toAddOverTime:Bool = true
    
    var moneyGive1:Int = 0
    var moneyGive2:Int = 0
    var moneyGive3:Int = 0
    
    var attrGive1:Int = 0
    var attrGive2:Int = 0
    
    var attrString1:String = ""
    var attrString2:String = ""
    
    var buttonCost1:Int = 0
    var buttonCost2:Int = 0
    var buttonCost3:Int = 0
    var buttonCost4:Int = 0
    var buttonCost5:Int = 0
    
    var buttonCount1:Int = 0
    var buttonCount2:Int = 0
    var buttonCount3:Int = 0
    var buttonCount4:Int = 0
    var buttonCount5:Int = 0
}

var data_s = Game_s()