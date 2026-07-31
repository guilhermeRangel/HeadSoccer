//
//  PersonagemEntity.swift
//  headSoccer
//
//  Created by Guilherme Rangel on 02/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import GameplayKit
import SpriteKit



final class Personagem: GKEntity {
    
    
    
    
    var spriteComponent: SpriteComponent?
    var spritePhysics: PhysicsComponent?
    var positionComponent : PostionComponent?
    
    convenience init(type: Elements) {
        self.init()
        
        let renderComponent = RenderComponent(node: SKNode())
        addComponent(renderComponent)
        let scaleComponent = ScaleComponent(node: renderComponent.node)
        
        
        
        switch type {
        case .enemy:
            let sprite = SpriteComponent(imageNamed: "enemy")
            sprite.spriteNode.name = "enemy"
            sprite.spriteNode.size = CGSize(width: sprite.spriteNode.size.width / 5,
                                            height: sprite.spriteNode.size.height / 5)
            let position = PostionComponent(node: renderComponent.node, type: .enemy)
            let physics = PhysicsComponent(nodePhysics: sprite.spriteNode, type: .enemy, nodeTexture: sprite.spriteNodeTexture)
            spriteComponent = sprite
            positionComponent = position
            spritePhysics = physics
            
        case .player:
            let sprite = SpriteComponent(imageNamed: "player")
            sprite.spriteNode.name = "player"
            sprite.spriteNode.size = CGSize(width: sprite.spriteNode.size.width / 5,
                                            height: sprite.spriteNode.size.height / 5)
            let position = PostionComponent(node: renderComponent.node, type: .player)
            let physics = PhysicsComponent(nodePhysics: sprite.spriteNode, type: .player, nodeTexture: sprite.spriteNodeTexture)
            spriteComponent = sprite
            positionComponent = position
            spritePhysics = physics
            
        case .ball:
            let sprite = SpriteComponent(imageNamed: "ball")
            sprite.spriteNode.name = "ball"
            sprite.spriteNode.size = CGSize(width: sprite.spriteNode.size.width / 8,
                                            height: sprite.spriteNode.size.height / 8)
            let position = PostionComponent(node: renderComponent.node, type: .ball)
            let physics = PhysicsComponent(nodePhysics: sprite.spriteNode, type: .ball, nodeTexture: sprite.spriteNodeTexture)
            spriteComponent = sprite
            positionComponent = position
            spritePhysics = physics
            
        }

       
        
        guard let positionComponent = positionComponent,
              let spritePhysics = spritePhysics,
              let spriteComponent = spriteComponent else {
            return
        }
        
        addComponent(positionComponent)
        addComponent(spritePhysics)
        addComponent(spriteComponent)
        
        renderComponent.node.addChild(spriteComponent.spriteNode)
       
        
        addComponent(scaleComponent)
      
}
}
