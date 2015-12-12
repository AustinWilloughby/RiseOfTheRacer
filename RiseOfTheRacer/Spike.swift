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
        self.yScale = 0.5
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}