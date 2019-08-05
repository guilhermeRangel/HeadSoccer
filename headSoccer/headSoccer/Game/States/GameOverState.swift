//
//  GameOverState.swift
//  headSoccer
//
//  Created by Guilherme Rangel on 05/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import GameplayKit

final class GameOverState: GKState {
    
    weak var scene : GameScene?
    
    init(scene: GameScene) {
        self.scene = scene
        super.init()
    }
    
    
    override func didEnter(from previousState: GKState?){
        
    }
}
