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
    let sceneCamera: SKCameraNode = SKCameraNode()
    
    //Player Instance
    var player:Player?
    
    //Level
    var level:Int?
    
    //Tiles
    var tiles:[Tile]?
    
    //Timer
    var counter:Int = 0
    var timer:NSTimer!
    var timerLabel:SKLabelNode = SKLabelNode(fontNamed:"Arial")
    
    //DeltaTime
    var lastUpdateTime: CFTimeInterval = CFTimeInterval(0)
    var deltaTime: CFTimeInterval = CFTimeInterval(0)
    
    let map:MapHandler = MapHandler()
    
    override func didMoveToView(view: SKView) {
        if !isCreated{
            isCreated = true
            
            self.physicsWorld.contactDelegate = self
            
            view.showsPhysics = true
            
            level = 1
            
            self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.world = SKNode()
            self.world?.name = "world"
            addChild(self.world!)
            
            self.camera?.name = "camera"
            
            self.overlay = SKNode()
            self.overlay?.zPosition = 10
            self.overlay?.name = "overlay"
            addChild(self.overlay!)
        }
        
        backgroundColor = SKColor.blackColor()
        tiles = map.ReadMap(GameMaps.map1)
        for tile in tiles!{
            self.addChild(tile)
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        timerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        timerLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
        timerLabel.fontSize = 45
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        timerLabel.position = CGPoint(x: -screenSize.width / 2 + 10, y: screenSize.height / 2 - 10)
        timerLabel.zPosition = 1
        
        player = Player(pos: CGPoint(x: 100.0, y: 200.0))
        self.addChild(player!)
        
        self.addChild(player!.myDebugLabel)
        sceneCamera.addChild(timerLabel)
        
        self.addChild(sceneCamera)
        self.camera = sceneCamera
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
        let action = SKAction.moveTo(player!.position, duration: 0.25)
        sceneCamera.runAction(action)
        player!.Update()
        timerLabel.text = String(format: "%02d:%02d:%02d", counter/6000, (counter/100)%60, counter%100)
    }
    
    func updateTime(){
        counter++
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & ObjectType.Player != 0) &&
            (secondBody.categoryBitMask & ObjectType.Tile != 0)) {
                if (firstBody.node?.position.y > secondBody.node?.position.y){
                    player!.jumping = false
                    player!.physicsBody?.affectedByGravity = false
                    player!.position.y += 30.0
                }
        }
        
        if ((firstBody.categoryBitMask & ObjectType.Player != 0) &&
            (secondBody.categoryBitMask & ObjectType.Spike != 0)) {
                if (firstBody.node?.position.y > secondBody.node?.position.y){
                    player!.shouldResetPosition = true
                }
        }
        
        if ((firstBody.categoryBitMask & ObjectType.Player != 0) &&
            (secondBody.categoryBitMask & ObjectType.Teleport != 0)) {
                
                for tile in tiles!{
                    tile.removeFromParent()
                }
                tiles?.removeAll()
                
                switch(level)
                {
                case 1?:
                    tiles = map.ReadMap(GameMaps.map2)
                    for tile in tiles!{
                        self.addChild(tile)
                    }
                    player!.shouldResetPosition = true
                    break;
                case 2?:
                    tiles = map.ReadMap(GameMaps.map3)
                    for tile in tiles!{
                        self.addChild(tile)
                    }
                    player!.shouldResetPosition = true
                    break;
                case 3?:
                    tiles = map.ReadMap(GameMaps.map4)
                    for tile in tiles!{
                        self.addChild(tile)
                    }
                    player!.shouldResetPosition = true
                    break;
                case 4?:
                    tiles = map.ReadMap(GameMaps.map5)
                    for tile in tiles!{
                        self.addChild(tile)
                    }
                    player!.shouldResetPosition = true
                    break;
                case 5?:
                    tiles = map.ReadMap(GameMaps.map6)
                    for tile in tiles!{
                        self.addChild(tile)
                    }
                    player!.shouldResetPosition = true
                    break;
                case 6?:
                    tiles = map.ReadMap(GameMaps.map7)
                    for tile in tiles!{
                        self.addChild(tile)
                    }
                    player!.shouldResetPosition = true
                    break;
                default:
                    tiles = map.ReadMap(GameMaps.map1)
                    for tile in tiles!{
                        self.addChild(tile)
                    }
                    player!.shouldResetPosition = true
                    break;
                }
        }
        
        //player!.myDebugLabel.text = "BeganContact"
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        player!.physicsBody?.affectedByGravity = true
        
        //player!.myDebugLabel.text = "EndedContact"
    }
}
