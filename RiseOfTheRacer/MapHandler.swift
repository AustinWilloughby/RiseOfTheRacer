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
        let scale:CGFloat = CGFloat(GameVariables.tileSize)
        var skipping:Bool = false
        
        for var y = 0; y < ySize; ++y{
            currentLine = map[y + 1]
            
 
            for var x = 0; x < xSize; ++x{
                
                skipping = false
                let index = currentLine.startIndex.advancedBy(x)
                let tempTile:Tile
                switch currentLine[index]{
                    case "W":
                        tempTile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: y * GameVariables.tileSize), textureName: "Wall", id:"W")
                        //tileArray[x][y] = newTile
                        break
                    case "P":
                        tempTile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: y * GameVariables.tileSize), textureName: "Platform", id:"P")
                        //tileArray[x][y] = newTile
                        break
                    case "S":
                         tempTile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: y * GameVariables.tileSize), textureName: "Spike", id:"S")
                        //tileArray[x][y] = newTile
                        break
                    case "<":
                         tempTile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: y * GameVariables.tileSize), textureName: "Spike", id:"<")
                        //tileArray[x][y] = newTile
                        break
                    case ">":
                         tempTile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: y * GameVariables.tileSize), textureName: "Spike", id:">")
                        //tileArray[x][y] = newTile
                        break
                    case "E":
                         tempTile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: y * GameVariables.tileSize), textureName: "Teleporter", id:"E")
                        //tileArray[x][y] = newTile
                        break
                    default:
                        tempTile = Tile(pos: CGPoint(x: x * GameVariables.tileSize, y: y * GameVariables.tileSize), textureName: "EmptyTile", id:"-")
                        skipping = true
                        break
                }
                
                if !skipping{
                    let scaleFactor = scale / tempTile.size.height
                    tempTile.xScale = scaleFactor
                    tempTile.yScale = scaleFactor
                    tiles.append(tempTile)
                }
            }
            
        }
        print(tiles.count)
        return tiles
    }
    
    
}