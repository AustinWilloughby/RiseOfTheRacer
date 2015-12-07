//
//  Tile.swift
//  RiseOfTheRacer
//
//  Created by igmstudent on 11/20/15.
//  Copyright © 2015 BigTipperGames. All rights reserved.
//

import SpriteKit
import Foundation

class Tile: GamePiece {
    private var tileID:Character
    
    
    override init(pos:CGPoint, textureName:String)
    {
        super.init(pos: pos, textureName: textureName)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 65.0, height: 80.0))
        self.physicsBody?.dynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}