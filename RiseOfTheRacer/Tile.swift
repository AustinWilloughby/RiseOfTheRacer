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
    private var tileID:String
    
    init(pos:CGPoint, textureName:String, id:String)
    {
        tileID = id
        super.init(pos: pos, textureName: textureName)
        
        let scale:CGFloat = CGFloat(GameVariables.tileSize)
        let scaleFactor = scale / size.height
        xScale = scaleFactor
        yScale = scaleFactor
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: Double(GameVariables.tileSize) * 1.3, height: Double(GameVariables.tileSize) * 2))
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = ObjectType.Tile
        self.physicsBody?.contactTestBitMask = ObjectType.Player
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}