//
//  GameScene.swift
//  RiseOfTheRacer
//
//  Created by igmstudent on 11/16/15.
//  Copyright (c) 2015 BigTipperGames. All rights reserved.
//
//  Implementation based off code found here: http://swiftalicio.us/2014/09/2d-camera-in-spritekit/



import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //To check if the camera exists
    var isCreated: Bool = false;
    //Root node of the world. Attach game entities (Tiles, Player, ...) here.
    var world: SKNode?
    //Root of the interface. Attach interface elements (Timer) here.
    var overlay: SKNode?
    //Actual camera node. Move this to change what is visible in the world.
    var sceneCamera: SKCameraNode?
    
    //Player Instance
    var player:Player?
    
    //Timer
    var counter:Int = 0
    var timer:NSTimer!
    var timerLabel:SKLabelNode = SKLabelNode(fontNamed:"Arial")
    
    //DeltaTime
    var lastUpdateTime: CFTimeInterval = CFTimeInterval(0)
    var deltaTime: CFTimeInterval = CFTimeInterval(0)
    
    //let map:MapHandler = MapHandler()

    override func didSimulatePhysics() {
        if self.sceneCamera != nil{
            self.focusOnCamera(self.sceneCamera!)
        }
    }
    
    override func didMoveToView(view: SKView) {
        if !isCreated{
            isCreated = true
            
            self.physicsWorld.contactDelegate = self
            
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
        
        //map.ReadMap(GameMaps.map1)
        
        let tile:Tile = Tile(pos: CGPoint(x: 0.0, y: -75.0), textureName: "Platform",  id:"T")
        let tile1:Tile = Tile(pos: CGPoint(x: 50.0, y: -205.0), textureName: "Platform",  id:"T")
        let tile2:Tile = Tile(pos: CGPoint(x: 100.0, y: -255.0), textureName: "Platform", id:"T")
        let tile3:Tile = Tile(pos: CGPoint(x: 150.0, y: -205.0), textureName: "Platform", id:"T")
        
        player = Player(pos: CGPoint(x: 0.0, y: 200.0))
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        timerLabel.fontSize = 45
        timerLabel.position = CGPoint(x: -400.0, y: 240.0)
        
        self.addChild(player!)
        self.addChild(tile)
        self.addChild(tile1)
        self.addChild(tile2)
        self.addChild(tile3)
        
        self.addChild(player!.myDebugLabel)
        sceneCamera!.addChild(timerLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       player!.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        player!.touchesEnded(touches, withEvent: event)
    }
    
    func focusOnCamera(node: SKCameraNode){
        let cameraPosInScene: CGPoint = (node.scene?.convertPoint(node.position, fromNode: node.parent!))!
        
        node.parent!.position = CGPoint(x:(node.parent?.position.x)! - cameraPosInScene.x, y:(node.parent?.position.y)! - cameraPosInScene.y)
    }
        
    override func update(currentTime: CFTimeInterval) {
        deltaTime = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        sceneCamera?.runAction(SKAction.moveTo(player!.position, duration: 0.0))
        player!.Update()
        timerLabel.text = String(format: "%02d:%02d:%02d", counter/6000, (counter/100)%60, counter%100)
    }
    
    func updateTime(){
        counter++
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        player!.jumping = false
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
