//
//  Machado.swift
//  PiratasViking
//
//  Created by Flavio Mitsuyoshi Tamanaha Ota on 03/04/15.
//  Copyright (c) 2015 Flameworks. All rights reserved.
//
// MARK: - Class Definition
class Machado : CCSprite {
	// MARK: - Public Objects
	var damage:CGFloat = 0.0

	// MARK: - Private Objects

	// MARK: - Life Cycle
	override init() {
		super.init()
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

	convenience init(imageNamed imageName: String!, andDamage:CGFloat) {
		self.init(imageNamed: imageName)
		
		// Configuracoes default
		self.damage = andDamage
        self.position = CGPointMake(0, 0)
        self.anchorPoint = CGPointMake(0.5, 0.5)
		self.rotation = 180.0

		self.physicsBody = CCPhysicsBody(rect: CGRectMake(0.0, 0.0, self.contentSize.width, self.contentSize.height), cornerRadius: 0.0)
		self.physicsBody.type = CCPhysicsBodyType.Kinematic
		self.physicsBody.friction = 1.0
		self.physicsBody.elasticity = 0.1
		self.physicsBody.mass = 100.0
		self.physicsBody.density = 100.0
		self.physicsBody.collisionType = "Machado"
		self.physicsBody.collisionCategories = ["Machado"]
		self.physicsBody.collisionMask = ["PirataPerneta, PirataPeixe"]
	}

	override func onEnter() {
		// Chamado apos o init quando entra no director
		super.onEnter()
	}
    
    override func update(delta: CCTime) {
        self.rotation += 20
    }
	
	// MARK: - Private Methods
	
	// MARK: - Public Methods
	
	// MARK: - Delegates/Datasources
	
	// MARK: - Death Cycle
	deinit {
		// Chamado no momento de desalocacao
	}
}
