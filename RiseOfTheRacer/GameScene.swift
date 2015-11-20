//
//  GameScene.swift
//  RiseOfTheRacer
//
//  Created by igmstudent on 11/16/15.
//  Copyright (c) 2015 BigTipperGames. All rights reserved.
//
//  Implementation based off code found here: http://swiftalicio.us/2014/09/2d-camera-in-spritekit/



import SpriteKit

class GameScene: SKScene {
    
    //To check if the camera exists
    var isCreated: Bool = false;
    //Root node of the world. Attach game entities (Tiles, Player, ...) here.
    var world: SKNode?
    //Root of the interface. Attach interface elements (Timer) here.
    var overlay: SKNode?
    //Actual camera node. Move this to change what is visible in the world.
    var sceneCamera: SKCameraNode?
    
    
    override func didMoveToView(view: SKView) {
        if !isCreated{
            isCreated = true

            self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.world = SKNode()
            self.world?.name = "world"
            addChild(self.world!)
            
            self.sceneCamera = SKCameraNode()
            self.camera?.name = "camera"
            self.world?.addChild(self.sceneCamera!)
            
            self.overlay = SKNode()
            self.overlay?.zPosition = 10
            self.overlay?.name = "overlay"
            addChild(self.overlay!)
        }
    }
    
    
    override func didSimulatePhysics() {
        if self.sceneCamera != nil{
            self.focusOnCamera(self.sceneCamera!)
        }
    }
    
    func focusOnCamera(node: SKCameraNode){
        let cameraPosInScene: CGPoint = (node.scene?.convertPoint(node.position, fromNode: node.parent!))!
        
        node.parent!.position = CGPoint(x:(node.parent?.position.x)! - cameraPosInScene.x, y:(node.parent?.position.y)! - cameraPosInScene.y)
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
//    override func didMoveToView(view: SKView) {
//        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!"
//        myLabel.fontSize = 45
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
//        
//        self.addChild(myLabel)
//    }
//    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//       /* Called when a touch begins */
//        
//        for touch in touches {
//            let location = touch.locationInNode(self)
//            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
//        }
//    }
}
