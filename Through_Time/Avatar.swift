//
//  Avatar.swift
//  Through Time
//
//  Created by Gregory Johnson on 3/1/15.
//  Copyright (c) 2015 Gregory Johnson. All rights reserved.
//

import UIKit

class Avatar
{
    var name:String
    var minAttack:Int
    var maxAttack:Int
    var defense:Int
    var maxHealth:Int
    var currHealth:Int
    var speed:Int
    
    //Init method to set up starting values
    init()
    {
        self.name = ""
        self.minAttack = 1
        self.maxAttack = 2
        self.defense = 0
        self.maxHealth = 100
        self.currHealth = 100
        self.speed = 1
    }
    
    //Increases the specific stat by the amount passed
    //If attack, max attack goes up by the amount and min attack goes up by 80% of the amount
    func increaseStat(amount:Int, stat:Character)
    {
        switch stat
        {
        case "a":
            self.minAttack += Int(Double(amount) * 0.8)
            self.maxAttack += amount
        case "d":
            self.defense += amount
        case "h":
            self.maxHealth += amount
            self.currHealth += amount
        case "s":
            self.speed += amount
        default:
            print("Wrong input for increasing stat.")
        }
    }
    
    //Take damage if defense is not strong enough to block it
    //Return -1 if health reaches 0, 1 otherwise
    func takeDamage(amount:Int) -> (damage:Int, alive:Bool)
    {
        let damage = amount - self.defense
        if(damage > 0)
        {
            self.currHealth = max(self.currHealth - damage, 0)
        }
        if(self.currHealth != 0)
        {
            return (damage, true)
        }
        return (damage, false)
    }
    
    //Deals damage witin the range of minAttack - maxAttack
    func getDamage() -> Int
    {
        return Int(arc4random_uniform(UInt32(self.maxAttack - self.minAttack + 1)) + UInt32(self.minAttack))
    }
    
    //Heal after paying to get health back after a battle
    func heal(amount:Int)
    {
        self.currHealth = min(self.maxHealth, self.currHealth + amount)
    }
    func heal()
    {
        self.currHealth = self.maxHealth
    }
    
    
    
}
