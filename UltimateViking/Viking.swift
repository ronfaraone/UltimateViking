//
//  Viking.swift
//  PiratasViking
//
//  Created by Flavio Mitsuyoshi Tamanaha Ota on 03/04/15.
//  Copyright (c) 2015 Flameworks. All rights reserved.
//

import Foundation

class Viking : CCSprite {
    
    // MARK: - Public Objects
    
    // MARK: - Private Objects
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        let agnar:CCSprite = CCSprite(imageNamed: "player-ipad.png")
        agnar.position = CGPointMake(0, 0)
        agnar.anchorPoint = CGPointMake(0.5, 0.5)
        
        self.addChild(agnar)
        
    }
    
    override init(CGImage image: CGImage!, key: String!) {
        super.init(CGImage: image, key: key)
    }
    
    override init(spriteFrame: CCSpriteFrame!) {
        super.init(spriteFrame: spriteFrame)
    }
    
    override init(texture: CCTexture!) {
        super.init(texture: texture)
    }
    
    override init(texture: CCTexture!, rect: CGRect) {
        super.init(texture: texture, rect: rect)
    }
    
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) {
        super.init(texture: texture, rect: rect, rotated: rotated)
    }
    
    override init(imageNamed imageName: String!) {
        super.init(imageNamed: imageName)
    }
    
    override func onEnter() {
        // Chamado apos o init quando entra no director
        super.onEnter()
    }
    
    // MARK: - Private Methods
    
    // MARK: - Public Methods
    
    // MARK: - Delegates/Datasources
    
    // MARK: - Death Cycle
    deinit {
        // Chamado no momento de desalocacao
    }
}