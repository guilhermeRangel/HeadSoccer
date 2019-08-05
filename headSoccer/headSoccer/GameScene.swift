//
//  GameScene.swift
//  headSoccer
//
//  Created by Guilherme Rangel on 01/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
     lazy var entityManager = EntityManager(scene: world)
    
    // The last known timestamp
    var lastTime: TimeInterval = 0.0
    
    // The world node
    var world: SKNode = SKNode()
    
    
   
    // The game state machine
    lazy var stateMachine = GKStateMachine(states: [GameRunningState(scene: self),
                                                    GamePausedState(scene: self),
                                                    GameOverState(scene: self),
                                                    GameTitleState(scene: self)])
    
    override func didMove(to view: SKView) {
        addChild(world)
        
//        dele

    }
   
    
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        // Update Entity Manager
        if lastTime != 0.0 { entityManager.update(with: currentTime - lastTime) }
        lastTime = currentTime
    }
    
  
    override public func touchesBegan ( _ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self){
            
            
//                    if location.x < nodes.position.x{
        
                       // print(location)
                        entityManager.sceneNode!.children[0].physicsBody?.applyImpulse(CGVector(dx: -10, dy: 0))
//                    }
                
            
            
            
            
        }
        // stateMachine.enter(stateMachine.currentState is GameRunningState ? GamePausedState.self : GameRunningState.self)
    }
    
    
}
