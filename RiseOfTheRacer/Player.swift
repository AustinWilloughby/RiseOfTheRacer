//
//  Player.swift
//  RiseOfTheRacer
//
//  Created by igmstudent on 11/18/15.
//  Copyright © 2015 BigTipperGames. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    var vel:CGPoint
    var acl:CGPoint
    
    var runAcl:CGFloat
    var jumpForce:CGFloat
    var gravity:CGFloat
    
    var playerTexture:SKTexture
    
    var running:Bool
    var facingRight:Bool
    var jumping:Bool
    
    var myDebugLabel:SKLabelNode
    
    init(pos:CGPoint)
    {
        self.playerTexture = SKTexture(imageNamed: "Player")
        self.vel = CGPoint(x: 0.0, y: 0.0)
        self.acl = CGPoint(x: 0.0, y: 0.0)
        
        self.running = false
        self.facingRight = true
        self.jumping = true
        
        self.runAcl = 0.03
        self.jumpForce = 15.0
        self.gravity = 0.4
        
        myDebugLabel = SKLabelNode(fontNamed:"Arial")
        myDebugLabel.fontSize = 45
        
        let texture = playerTexture
        
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        self.position = pos
        self.xScale = 0.30
        self.yScale = 0.60
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        //myDebugLabel.text = "Touches: " + String(event?.allTouches()!.count)
        
        if event?.allTouches()?.count > 1 && jumping == false{
            jumping = true
            vel = CGPoint(x: vel.x, y: vel.y + jumpForce)
        }
        
        else {
            let location = touches.first!.locationInNode(self)
        
            if location.x > CGRectGetMaxX(self.frame) - 100
            {
                facingRight = true
                running = true
            }
            else if location.x < CGRectGetMinX(self.frame) + 100
            {
                facingRight = false
                running = true
            }
        }
    }
    
    func Update(){
        myDebugLabel.position = CGPoint(x: position.x, y: position.y + 100)
        
        if position.y < 0 {
            vel.y = 0
            position.y = 0
            jumping = false
        }
        
        if running == true && facingRight == true {
            acl = CGPoint(x: acl.x + runAcl, y: acl.y)
        }
            
        else if running == true && facingRight == false {
            acl = CGPoint(x: acl.x - runAcl, y: acl.y)
        }
            
        else {
            vel = CGPoint(x: 0.0, y: vel.y)
            acl = CGPoint(x: 0.0, y: acl.y)
        }
        
        self.vel = CGPoint(x: vel.x + acl.x, y: vel.y + acl.y)
        self.position = CGPoint(x: vel.x + self.position.x, y: vel.y + self.position.y)
        self.vel = CGPoint(x: vel.x / 1.05, y: vel.y - gravity)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}