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
    
    init(){
        level = 1
    }
    
    
    func ReadMap(map:[String])->[Tile]{
        var currentLine = map[0]
        var coords = currentLine.characters.split{$0 == ","}.map(String.init)
        let xSize:Int = Int(coords[0])!
        let ySize:Int = Int(coords[1])!
        
        var tiles = [Tile]()
        
        for var y = 0; y < ySize; ++y{
            currentLine = map[y + 1]
            
 
            for var x = 0; x < xSize; ++x{
                
                let index = currentLine.startIndex.advancedBy(x)
                let tempTile:Tile
                switch currentLine[index]{
                    case "W":
                        tempTile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: (ySize - y) * GameVariables.tileSize), textureName: "Wall", id:"W")
                         tiles.append(tempTile)
                        break
                    case "P":
                        tempTile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: (ySize - y) * GameVariables.tileSize), textureName: "Platform", id:"P")
                         tiles.append(tempTile)
                        break
                    case "S":
                         tempTile = Spike(pos: CGPoint(x: x * GameVariables.tileSize, y: (ySize - y) * GameVariables.tileSize), textureName: "Spike", id:"S")
                         tiles.append(tempTile)
                        break
                    case "<":
                         tempTile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: (ySize - y) * GameVariables.tileSize), textureName: "Spike", id:"<")
                         tiles.append(tempTile)
                        break
                    case ">":
                         tempTile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: (ySize - y) * GameVariables.tileSize), textureName: "Spike", id:">")
                         tiles.append(tempTile)
                        break
                    case "E":
                         tempTile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: (ySize - y) * GameVariables.tileSize), textureName: "Teleporter", id:"E")
                         tiles.append(tempTile)
                        break
                    default:
                        break
                }
            }
            
        }
        return tiles
    }
    
    
}