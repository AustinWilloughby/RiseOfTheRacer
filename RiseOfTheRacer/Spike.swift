//
//  Spike.swift
//  RiseOfTheRacer
//
//  Created by igmstudent on 11/20/15.
//  Copyright © 2015 BigTipperGames. All rights reserved.
//

import SpriteKit
import Foundation

class Spike: Tile {
    override init(pos:CGPoint, textureName:String, id:String)
    {
        super.init(pos: pos, textureName: textureName, id: id)
        
        self.physicsBody?.categoryBitMask = ObjectType.Spike
        
        if id == "S"
        {
            
            self.yScale = 0.25
            self.position.y -= 16.0
        }
        if id == "<"
        {
            print("!")
            runAction(SKAction.rotateToAngle(90.0, duration: 0, shortestUnitArc: true))
        }
        if id == ">"
        {
            runAction(SKAction.rotateToAngle(90.0, duration: 0, shortestUnitArc: true))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}