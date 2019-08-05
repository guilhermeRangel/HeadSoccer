//
//  PositionComponent.swift
//  headSoccer
//
//  Created by Guilherme Rangel on 02/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import GameplayKit


final class PostionComponent: GKComponent {

    var node: SKNode
    

    init(node: SKNode) {
        self.node = node
        super.init()
      
        print(node.name)
        if node.name == "player"{
            node.position = CGPoint(x: -250,
                                    y: (0 - ((node.position.y) / 2) * 0.5))
            

        }

//        node.position = CGPoint(x: (0 - ((node.position.x) / 2) * 0.8),
//                                y: (0 - ((node.position.y) / 2) * 0.5))

        //MARK - AJUSTAR CONFORME A SCENE
       
    }
    
    func setPositionPlayer(node: SKNode){
     
       
    }
    
    func setPositionHud (){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
