//
//  HomeScene.swift
//  UltimateViking
//
//  Created by Ronaldo Faraone on 3/30/15.
//  Copyright (c) 2015 Fiap. All rights reserved.
//
import Foundation

// MARK: - Class Definition
class HomeScene : CCScene {
    
	// MARK: - Public Objects
    var bestScore:CCLabelTTF = CCLabelTTF(string: "Best Score: 0", fontName: "Verdana-Bold", fontSize: 18.0)
    
	// MARK: - Private Objects
	private let screenSize:CGSize = CCDirector.sharedDirector().viewSize()

	// MARK: - Life Cycle
	override init() {
		super.init()

        // Adiciona o background
        let background:CCSprite = CCSprite(imageNamed: "uv-background.png")
        background.position = CGPointMake(screenSize.width/2, screenSize.height/2)
        background.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(background)
        
//        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile("PirataPerneta-ipad.plist", textureFilename:"PirataPerneta-ipad.png")
//        let ccFrameName:CCSpriteFrame = CCSpriteFrame.frameWithImageNamed("PirataPerneta1.png") as CCSpriteFrame
//        let sprite:CCSprite = CCSprite.spriteWithSpriteFrame(ccFrameName) as CCSprite
//        sprite.position = CGPointMake(self.screenSize.width - 80, self.screenSize.height/2)
//        sprite.anchorPoint = CGPointMake(0.5, 0.5)
//        self.addChild(sprite)

        // Titulo
        let label:CCSprite = CCSprite(imageNamed: "uv-logo.png")
        label.position = CGPointMake(self.screenSize.width/9.0 * 3.5  , self.screenSize.height)
        label.anchorPoint = CGPointMake(1.0, 1.0)
        self.addChild(label)

		// ToGame Button
		let toGameButton:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed("start.png") as CCSpriteFrame)
		toGameButton.position = CGPointMake(self.screenSize.width/2.0, self.screenSize.height/2 - 20)
		toGameButton.anchorPoint = CGPointMake(0.5, 0.5)
//		toGameButton.setTarget(self, selector:"startTap:")
		toGameButton.block = {_ in StateMachine.sharedInstance.changeScene(StateMachineScenes.GameScene, isFade:true)}
		self.addChild(toGameButton)
        
        bestScore.color = CCColor.whiteColor()
        bestScore.position = CGPointMake(self.screenSize.width/2.0, 30)
        bestScore.anchorPoint = CGPointMake(0.5, 0)
        self.addChild(bestScore)
	}

	override func onEnter() {
		// Chamado apos o init quando entra no director
		super.onEnter()
	}

	// MARK: - Private Methods
//	func startTap(sender:AnyObject) {
//		StateMachine.sharedInstance.changeScene(StateMachine.StateMachineScenes.GameScene, isFade:true)
//	}

	// MARK: - Public Methods

	// MARK: - Delegates/Datasources

	// MARK: - Death Cycle
	override func onExit() {
		// Chamado quando sai do director
		super.onExit()
	}
}
