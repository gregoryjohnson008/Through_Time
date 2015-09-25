//
//  structureForData.swift
//  Through Time
//
//  Created by Gregory Johnson on 3/1/15.
//  Copyright (c) 2015 Gregory Johnson. All rights reserved.
//

import UIKit
import AVFoundation


enum UIUserInterfaceIdiom : Int
{
    case Unspecified
    case Phone
    case Pad
}

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}

//holds all data to be used in different views
struct Game_s
{
    var money:Float64 = 0
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
    
    var im_buttons:UIImage? = UIImage(named: "Parchment")
    
    var audioURL:NSURL? = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music_game", ofType: "mp3")!)
    var musicFile = AVAudioPlayer()
    
    var musicIsPlaying:Bool = false
    var musicStarted:Bool = false
    
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
    
    func startEra()
    {
        switch timePeriod
        {
        case Era.Caveman:
            _ = Era_Caveman()
        case Era.AncientEgypt:
            print("Egypt")
        default:
            print("Era wrong")
            
        }
    }
    
    var eraStarted:Bool = false
    
    /* Need to implement a multiplier for image size and peg spacing to create the same experience on every device */
    var mult:CGFloat = (DeviceType.IS_IPHONE_4_OR_LESS || DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_6 ? 2 : 3)
}

var data_s = Game_s()

let DeviceList = [
    /* iPod 5 */          "iPod5,1": "iPod Touch 5",
    /* iPhone 4 */        "iPhone3,1":  "iPhone 4", "iPhone3,2": "iPhone 4", "iPhone3,3": "iPhone 4",
    /* iPhone 4S */       "iPhone4,1": "iPhone 4S",
    /* iPhone 5 */        "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5",
    /* iPhone 5C */       "iPhone5,3": "iPhone 5C", "iPhone5,4": "iPhone 5C",
    /* iPhone 5S */       "iPhone6,1": "iPhone 5S", "iPhone6,2": "iPhone 5S",
    /* iPhone 6 */        "iPhone7,2": "iPhone 6",
    /* iPhone 6 Plus */   "iPhone7,1": "iPhone 6 Plus",
    /* Simulator */       "x86_64": "Simulator", "i386": "Simulator"
]

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machine = systemInfo.machine
        let mirror = Mirror(reflecting: machine)  // Swift 2.0
        var identifier = ""
        
        // Swift 2.0 and later - if you use Swift 2.0 uncomment his loop
         for child in mirror.children where child.value as? Int8 != 0 {
             identifier.append(UnicodeScalar(UInt8(child.value as! Int8)))
         }
        
        return DeviceList[identifier] ?? identifier
    }
    
}