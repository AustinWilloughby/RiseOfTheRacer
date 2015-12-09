//
//  MapHandler.swift
//  RiseOfTheRacer
//
//  Created by igmstudent on 11/20/15.
//  Copyright © 2015 BigTipperGames. All rights reserved.
//

import Foundation
import SpriteKit

class MapHandler{
    private var level:Int = 1
    internal var tileArray = [[Tile]]()
    
    init(){
        level = 1
    }
    
    
    func ReadMap(map:[String]){
        var currentLine = map[0]
        var coords = currentLine.characters.split{$0 == ","}.map(String.init)
        let xSize:Int = Int(coords[0])!
        let ySize:Int = Int(coords[1])!
        
        for var y = 0; y < ySize; ++y{
            currentLine = map[y + 1]
            
 
            for var x = 0; x < xSize; ++x{
                
                let index = currentLine.startIndex.advancedBy(x)
                switch currentLine[index]{
                    case "W":
                        let newTile:Tile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: y * GameVariables.tileSize), textureName: "Wall", id:"W")
                        tileArray[x][y] = newTile
                        break
                    case "P":
                        let newTile:Tile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: y * GameVariables.tileSize), textureName: "Platform", id:"P")
                        tileArray[x][y] = newTile
                        break
                    case "S":
                        let newTile:Tile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: y * GameVariables.tileSize), textureName: "Spike", id:"S")
                        tileArray[x][y] = newTile
                        break
                    case "<":
                        let newTile:Tile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: y * GameVariables.tileSize), textureName: "Spike", id:"<")
                        tileArray[x][y] = newTile
                        break
                    case ">":
                        let newTile:Tile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: y * GameVariables.tileSize), textureName: "Spike", id:">")
                        tileArray[x][y] = newTile
                        break
                    case "E":
                        let newTile:Tile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: y * GameVariables.tileSize), textureName: "Teleporter", id:"E")
                        tileArray[x][y] = newTile
                        break
                    default:
                        let newTile:Tile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: y * GameVariables.tileSize), textureName: "EmptyTile", id:"B")
                        tileArray[x][y] = newTile
                        break
                }
            }
            
        }
    }
    
    
}