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
    
    
    func ReadMap(mapFilePath: String){
        let input = StreamReader(path: mapFilePath)
        
        var currentLine = input?.nextLine()
        var coords = currentLine?.characters.split{$0 == ","}.map(String.init)
        var xSize:Int = Int(coords![0])!
        var ySize:Int = Int(coords![1])!
    }
    
    
}