//
//  GameVariables.swift
//  RiseOfTheRacer
//
//  Created by igmstudent on 11/20/15.
//  Copyright © 2015 BigTipperGames. All rights reserved.
//

import Foundation

struct GameVariables {
    static let tileSize:Int = 64
    //static var screenPosition:CGPoint = CGPoint(-200.0, -10.0)
}

struct ObjectType {
    static let None: UInt32 = 0
    static let All: UInt32 = UInt32.max
    static let Player:   UInt32 =  0b1         // 1
    static let Tile:     UInt32 =  0b10        // 2
    static let Spike:    UInt32 =  0b100       // 4
    static let Spike2:   UInt32 =  0b1000      // 8
    static let Teleport: UInt32 =  0b10000     // 16
}

enum CharacterState //Manages the state of the Character
{
    case standing
    case runningLeft
    case runningRight
    case jumping
    case dead
}

enum GameState //Manages the state of the game
{
    case mainMenu
    case highScore
    case pause
    case game
    case gameOver
    case difficulty
    case startScreen
}

enum MainMenuState //Manages the state of the menu
{
    case start
    case leaderboards
    case options
}

enum PauseMenuState //Manages the state of the pause menu
{
    case resume
    case menu
    case exit
}

enum GameDifficulty //Manages the game difficulty
{
    case tutorial
    case easy
    case medium
    case hard
    case hardPlus
}
