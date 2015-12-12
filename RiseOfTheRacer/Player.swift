//
//  Player.swift
//  RiseOfTheRacer
//
//  Created by igmstudent on 11/18/15.
//  Copyright © 2015 BigTipperGames. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
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
        
        self.runAcl = 100.0
        self.jumpForce = 5000.0
        
        myDebugLabel = SKLabelNode(fontNamed:"Arial")
        myDebugLabel.fontSize = 45
        
        let texture = playerTexture
        
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 50.0, height: 50.0))
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = ObjectType.Player
        self.physicsBody?.contactTestBitMask = ObjectType.All
        
        self.position = pos
        self.xScale = 0.40
        self.yScale = 0.80
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        touchList.append(touches.first!)
        
        if touchList.count > 1 && jumping == false{
            jumping = true
            physicsBody?.applyForce(CGVector(dx: 0.0, dy: jumpForce))
        }
        
        else {
            let location = touchList.first!.locationInNode(self)
        
            if location.x > 0
            {
                //myDebugLabel.text = String("Run Right")
                facingRight = true
                running = true
            }
            else if location.x < 0
            {
                //myDebugLabel.text = String("Run Left")
                facingRight = false
                running = true
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for var i = 0; i < touches.count; i++
        {
            if touchList.count > 0 {
                touchList.removeLast()
            }
        }
        
        if touchList.count == 0 {
            running = false
        }
    }
    
    func Update(){
        myDebugLabel.position = CGPoint(x: position.x, y: position.y + 100)
        
        myDebugLabel.text = String(touchList.count)
        
        //myDebugLabel.text = String(jumping)
        
        if running == true && facingRight == true {
            physicsBody?.applyForce(CGVector(dx: runAcl, dy: 0.0))
        }
            
        else if running == true && facingRight == false {
            physicsBody?.applyForce(CGVector(dx: -runAcl, dy: 0.0))
        }
            
        else {
            physicsBody?.velocity = CGVector(dx: 0.0, dy: (physicsBody?.velocity.dy)!)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}