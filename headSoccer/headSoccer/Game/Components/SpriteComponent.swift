//
//  SpriteComponent.swift
//  headSoccer
//
//  Created by Guilherme Rangel on 02/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import GameplayKit

final class SpriteComponent: GKComponent {
    
    let spriteNode: SKSpriteNode
    let spriteNodeTexture: SKTexture
    
    init(imageNamed imageName: String) {
        spriteNode = SKSpriteNode(imageNamed: imageName)
        spriteNodeTexture = SKTexture(imageNamed: imageName)
        super.init()
    }
    
    deinit {
        print("Desalocado nodo \(spriteNode.name)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
