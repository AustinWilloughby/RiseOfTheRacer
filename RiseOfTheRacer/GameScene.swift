//
//  GameScene.swift
//  RiseOfTheRacer
//
//  Created by igmstudent on 11/16/15.
//  Copyright (c) 2015 BigTipperGames. All rights reserved.
//
//  Implementation based off code found here: http://swiftalicio.us/2014/09/2d-camera-in-spritekit/


import AVFoundation
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
    
    //Sounds
    let deathNoise = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!)
    let teleportNoise = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("teleport", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
    
    //Level
    var level:Int = 0
    var levelLabel:SKLabelNode = SKLabelNode(fontNamed:"Arial")
    
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
            
            //view.showsPhysics = true
            
            self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.world = SKNode()
            self.world?.name = "world"
            addChild(self.world!)
            
            self.camera?.name = "camera"
            
            self.overlay = SKNode()
            self.overlay?.zPosition = 10
            self.overlay?.name = "overlay"
            addChild(self.overlay!)
            
            // Create map
            backgroundColor = SKColor.blackColor()
            tiles = map.ReadMap(GameMaps.menuMap)
            for tile in tiles!{
                self.addChild(tile)
            }
            
            var tempPos:CGPoint = CGPoint(x: 0.0, y: 100.0)
            
            // If there is a spawn tile
            for tile in tiles! {
                if tile.tileID == "X" {
                    // Update spawn point
                    tempPos = CGPoint(x: tile.position.x, y: tile.position.y)
                    camera?.position = tempPos
                }
            }
            
            player = Player(pos: tempPos)
            player?.zPosition = 1
            self.addChild(player!)
            
            // Create level label
            level = 0
            levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
            levelLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
            levelLabel.fontSize = 45
            let screenSize: CGRect = UIScreen.mainScreen().bounds
            levelLabel.position = CGPoint(x: -screenSize.width / 2 + 10, y: screenSize.height / 2 - 10)
            levelLabel.zPosition = 1
            levelLabel.text = "Level: " + String(level)
            
            // Create timer
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateTime", userInfo: nil, repeats: true)
            timerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
            timerLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
            timerLabel.fontSize = 45
            timerLabel.position = CGPoint(x: -screenSize.width / 2 + 10, y: screenSize.height / 2 - 55)
            timerLabel.zPosition = 1
            
            // Add labels
            self.addChild(player!.myDebugLabel)
            sceneCamera.addChild(timerLabel)
            sceneCamera.addChild(levelLabel)
            
            // Add camera
            self.addChild(sceneCamera)
            self.camera = sceneCamera
        }
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
        
        if player!.shouldUpdateSpawnpoint {
            for tile in tiles! {
                if tile.tileID == "X" {
                    // Update spawn point tile position
                    tile.position = player!.position
                    tile.position.y += 10
                    player!.shouldUpdateSpawnpoint = false
                }
            }
        }
        
        //player!.myDebugLabel.text = String(level)
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
                    //player!.physicsBody?.affectedByGravity = false
                    //player!.position.y += 30.0
                }
        }
        
        if ((firstBody.categoryBitMask & ObjectType.Player != 0) &&
            (secondBody.categoryBitMask & ObjectType.Spike != 0)) {
                if (firstBody.node?.position.y > secondBody.node?.position.y){
                    do {
                        self.audioPlayer = try AVAudioPlayer(contentsOfURL: deathNoise)
                        audioPlayer.prepareToPlay()
                        audioPlayer.play()
                    } catch{
                        print("Error getting the audio file")
                    }
                    player!.shouldResetPosition = true
                }
        }
        
        if ((firstBody.categoryBitMask & ObjectType.Player != 0) &&
            (secondBody.categoryBitMask & ObjectType.Spike2 != 0)) {
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOfURL: deathNoise)
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                } catch{
                    print("Error getting the audio file")
                }
                player!.shouldResetPosition = true
        }
        
        if ((firstBody.categoryBitMask & ObjectType.Player != 0) &&
            (secondBody.categoryBitMask & ObjectType.Teleport != 0)) {
                for tile in tiles!{
                    tile.removeFromParent()
                }
                tiles?.removeAll()
                
                switch(level)
                {
                case 0:
                    tiles = map.ReadMap(GameMaps.map1)
                    loadNewMap()
                    break
                case 1:
                    tiles = map.ReadMap(GameMaps.map2)
                    loadNewMap()
                    break;
                case 2:
                    tiles = map.ReadMap(GameMaps.map3)
                    loadNewMap()
                    break;
                case 3:
                    tiles = map.ReadMap(GameMaps.map4)
                    loadNewMap()
                    break;
                case 4:
                    tiles = map.ReadMap(GameMaps.map5)
                    loadNewMap()
                    break;
                case 5:
                    tiles = map.ReadMap(GameMaps.map6)
                    loadNewMap()
                    break;
                case 6:
                    tiles = map.ReadMap(GameMaps.map7)
                    loadNewMap()
                    break
                default:
                    tiles = map.ReadMap(GameMaps.map1)
                    loadNewMap()
                    break
                }
                
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOfURL: teleportNoise)
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                } catch{
                    print("Error getting the audio file")
                }
                
                level++
                levelLabel.text = "Level: " + String(level)
        }
        
        //player!.myDebugLabel.text = "BeganContact"
    }
    
    func loadNewMap(){
        for tile in tiles!{
            self.addChild(tile)
        }
        for tile in tiles! {
            if tile.tileID == "X" {
                // Update spawn point
                player!.spawnPoint = CGPoint(x: tile.position.x, y: tile.position.y)
                camera?.position = CGPoint(x: tile.position.x, y: tile.position.y)
            }
        }
        player!.shouldResetPosition = true
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        //player!.physicsBody?.affectedByGravity = true
        
        //player!.myDebugLabel.text = "EndedContact"
    }
}
