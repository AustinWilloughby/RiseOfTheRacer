//
//  Player.swift
//  RiseOfTheRacer
//
//  Created by igmstudent on 11/18/15.
//  Copyright © 2015 BigTipperGames. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode, SKPhysicsContactDelegate {
    var runAcl:CGFloat
    var jumpForce:CGFloat
    
    var playerTexture:SKTexture
    
    var running:Bool
    var facingRight:Bool
    var jumping:Bool
    
    var touchList:[UITouch]
    
    var myDebugLabel:SKLabelNode
    
    init(pos:CGPoint)
    {
        self.playerTexture = SKTexture(imageNamed: "Player")
        
        self.running = false
        self.facingRight = true
        self.jumping = false
        
        self.touchList = []
        
        self.runAcl = 0.005
        self.jumpForce = 0.30
        
        myDebugLabel = SKLabelNode(fontNamed:"Arial")
        myDebugLabel.fontSize = 45
        
        let texture = playerTexture
        
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 0.60, height: 0.30))
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        
        self.position = pos
        self.xScale = 0.30
        self.yScale = 0.60
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        touchList.append(touches.first!)
        
        if touchList.count > 1 && jumping == false{
            myDebugLabel.text = String("Jump")
            jumping = true
            physicsBody?.applyForce(CGVector(dx: 0.0, dy: jumpForce))
        }
        
        else {
            let location = touchList.first!.locationInNode(self)
        
            if location.x > position.x
            {
                myDebugLabel.text = String("Run Right")
                facingRight = true
                running = true
            }
            else if location.x < position.x
            {
                myDebugLabel.text = String("Run Left")
                facingRight = false
                running = true
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touchList.count > 0 {
            touchList.removeLast()
        }
        
        if touchList.count == 0 {
            running = false
        }
    }
    
    func Update(){
        myDebugLabel.position = CGPoint(x: position.x, y: position.y + 100)
        
        if physicsBody?.velocity.dy < 0.1 {
            jumping = false
        }
        
        if running == true && facingRight == true {
            physicsBody?.applyForce(CGVector(dx: runAcl, dy: 0.0))
        }
            
        else if running == true && facingRight == false {
            physicsBody?.applyForce(CGVector(dx: -runAcl, dy: 0.0))
        }
            
        else {
            physicsBody?.applyForce(CGVector(dx: 0.0, dy: 0.0))
            physicsBody?.applyForce(CGVector(dx: 0.0, dy: 0.0))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}