//
//  GamePiece.swift
//  RiseOfTheRacer
//
//  Created by igmstudent on 11/20/15.
//  Copyright © 2015 BigTipperGames. All rights reserved.
//

import SpriteKit
import Foundation

class GamePiece: SKSpriteNode, SKPhysicsContactDelegate {
    
    init(pos:CGPoint, textureName:String)
    {
        let texture = SKTexture(imageNamed: textureName)
        
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        self.position = pos
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}