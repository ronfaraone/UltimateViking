//
//  Main.swift
//  UltimateViking
//
//  Created by Ronaldo Faraone on 3/30/15.
//  Copyright (c) 2015 Fiap. All rights reserved.
//
import Foundation

@UIApplicationMain class AppDelegate : CCAppDelegate, UIApplicationDelegate {

	// MARK: Life Cycle
	override func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
		setupCocos2dWithOptions([CCSetupShowDebugStats: false])

		return true
	}

	// MARK: Override Methods
	override func startScene() -> (CCScene) {
		return LoadingScene()
	}

	// MARK: Multi task delegates
	override func applicationWillResignActive(application:UIApplication) {
		println("Resign Active")
	}
	
	override func applicationDidBecomeActive(application:UIApplication) {
		println("Become Active")
	}
	
	override func applicationDidEnterBackground(application:UIApplication) {
		println("Enter Background")
	}
	
	override func applicationWillEnterForeground(application:UIApplication) {
		println("Enter Foreground")
	}
}
