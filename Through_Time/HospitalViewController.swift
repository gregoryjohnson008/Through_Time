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
    
    @IBOutlet weak var healMe_button: UIButton!
    @IBOutlet weak var price_lbl: UILabel!
    @IBOutlet weak var money_lbl: UILabel!
    @IBOutlet weak var health_lbl: UILabel!
    @IBOutlet weak var statHealed_lbl: UILabel!
    
    var priceMultiplier:Int = 0
    var standardPricePerHealth:Int = 50
    var eraCost:Int = 0
    
    let transitionManager = TransitionManager(direction: TransitionManager.Direction.down)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI elements for the button
        switch data_s.timePeriod
        {
        case Game_s.Era.Caveman:
            healMe_button.titleLabel!.font = UIFont(name: "Chalkduster", size: 38.0)
            priceMultiplier = 1
        default:
            print("Something is wront with current era")
        }
        
        eraCost = (standardPricePerHealth * priceMultiplier)
        
        healMe_button.layer.shadowColor = UIColor.blackColor().CGColor
        healMe_button.layer.shadowOffset = CGSizeMake(5, 5)
        healMe_button.layer.shadowRadius = 5
        healMe_button.layer.shadowOpacity = 0.5
        
        // Set up labels
        price_lbl.text = "Price: \(eraCost)/health"
        _ = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateMoney"), userInfo: nil, repeats: true)
        updateLabels()
        
    }
    
    func updateMoney()
    {
        self.money_lbl.text = String(format: "%i gold", Int(data_s.money))
    }
    
    func updateLabels()
    {
        health_lbl.text = "Health: \(data_s.avatar.currHealth)/\(data_s.avatar.maxHealth)"
        statHealed_lbl.text = "Total healed for era: \(data_s.totalHealedForEra)"
    }
    
    @IBAction func healPressed(sender: AnyObject)
    {
        if(data_s.avatar.currHealth != data_s.avatar.maxHealth)
        {
            let cost:Int = (data_s.avatar.maxHealth - data_s.avatar.currHealth) * eraCost //cost to full health
            var amount:Int = 0
            
            if(data_s.money > Double(cost))
            {
                amount = data_s.avatar.maxHealth - data_s.avatar.currHealth
                data_s.money -= Double(cost)
                data_s.avatar.heal() //full health
                print("Healed to full")
            }
            else
            {
                // money/eraCost = amount of health to get
                amount = Int(data_s.money/Double(eraCost))
                data_s.money -= Double(amount * eraCost)
                data_s.avatar.heal(amount)
                print("Healed for \(amount) costing \(amount * eraCost)")
            }
            
            data_s.totalHealedForEra += amount
            updateLabels()
        }
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