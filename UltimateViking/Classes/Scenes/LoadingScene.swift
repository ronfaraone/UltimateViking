//
//  LoadingScene.swift
//  UltimateViking
//
//  Created by Ronaldo Faraone on 3/30/15.
//  Copyright (c) 2015 Fiap. All rights reserved.
//
import Foundation

// MARK: - Class Definition
class LoadingScene : CCScene {
	// MARK: - Public Objects

	// MARK: - Private Objects
	private let screenSize:CGSize = CCDirector.sharedDirector().viewSize()

	// MARK: - Life Cycle
	override init() {
		super.init()

        let background:CCSprite = CCSprite(imageNamed: "uv-background.png")
        background.position = CGPointMake(screenSize.width/2, screenSize.height/2)
        background.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(background)
        
		// Label loading
		let label:CCLabelTTF = CCLabelTTF(string: "Loading...", fontName: "Chalkduster", fontSize: 36.0)
		label.color = CCColor.whiteColor()
		label.position = CGPointMake(self.screenSize.width/2, self.screenSize.height/2)
		label.anchorPoint = CGPointMake(0.5, 0.5)
		self.addChild(label)
        
        // Preload das musicas
        SoundPlayHelper.sharedInstance.preloadSoundsAndMusic()
        SoundPlayHelper.sharedInstance.setMusicDefaultVolume()
        
        // Preload dos plist
        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile("PirataPerneta-ipad.plist")
        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile("PirataPeixe-ipad.plist")

		DelayHelper.sharedInstance.callBlock({ _ in
			StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)
		}, withDelay: 1.0)
	}

	override func onEnter() {
		// Chamado apos o init quando entra no director
		super.onEnter()
	}

	// MARK: - Private Methods

	// MARK: - Public Methods

	// MARK: - Delegates/Datasources

	// MARK: - Death Cycle
	override func onExit() {
		// Chamado quando sai do director
		super.onExit()
	}
}
