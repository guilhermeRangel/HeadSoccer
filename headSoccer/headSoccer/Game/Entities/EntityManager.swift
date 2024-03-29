//
//  EntityManager.swift
//  headSoccer
//
//  Created by Guilherme Rangel on 02/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import GameplayKit
import SpriteKit

// The manager for the entities
final class EntityManager {
    
    // The entities from the game
    var entities: [GKEntity] = []
    
    weak var sceneNode: SKNode?
    
    /// Designed Initializer
    init(scene: SKNode) {
        self.sceneNode = scene
    }
    
    /// Make sure to give the opportunity for all objects to update
    func update(with delta: TimeInterval) {
        entities.forEach {
            $0.update(deltaTime: delta)
        }
    }
    
    // MARK: - CRUD
    
    // This will make sure that the entity will be added to both the gameplay part
    // and the visual part
    func add(entity: GKEntity) {
        // Gets the component that has the visual part
        if let node = entity.component(ofType: RenderComponent.self)?.node {
            sceneNode?.addChild(node)
       
          
        }
        entities.append(entity)
    }
    /// This will make sure that the entity will removed from tha gameplay part
    /// and the visual part
    func remove(entity: GKEntity) {
        // Gets the component that has the visual part
        entity.component(ofType: RenderComponent.self)?.node.removeFromParent()
        entities.removeAll{ $0 == entity }
    }
    func removeAllEntities() {
        while let entity = entities.last { remove(entity: entity) }
    }
}

