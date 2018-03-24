//
//  BlockerTests.swift
//  blockerTests
//
//  Created by Evan Conrad on 3/23/18.
//  Copyright © 2018 Evan Conrad & Rudy Bermudez. All rights reserved.
//

import XCTest

class BlockerTests: XCTestCase {
    
    func tmpItemManager() -> BlockerItemManager {
        
        // Setup a temporary folder that we can run each test in.
        let tmp = FileManager.default.temporaryDirectory
        let randoFolder = UUID().uuidString
        let baseURL : URL = tmp.appendingPathComponent(randoFolder, isDirectory: true)
        
        // Attempt to create the directory
        do {
           try FileManager.default.createDirectory(at: baseURL, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        
        let fileManager = BlockerFileManager(baseURL: baseURL)
        let itemManager = BlockerItemManager(fileManager: fileManager)
        fileManager.createEmptyBlockerFile()
        
        return itemManager
    }
    
    func testCreatingAManagerDoesntCrash() {
        let fileManager = BlockerFileManager()
        _ = BlockerItemManager(fileManager: fileManager)
        fileManager.createEmptyBlockerFile()
        // we didnt crash, yay!
    }
    
    func testCreatingASimpleManagerDoesntCrash() {
        _ = BlockerItemManager()
        // we didnt crash, yay!
    }

    func testTogglingAnItemFalse() {
        let itemManager = tmpItemManager()
        
        let toggled = itemManager.toggle(item: Social.imgur, enable: false)
        XCTAssertFalse(toggled)
    }
    
    func testTogglingAnItemTrue() {
        let itemManager = tmpItemManager()
    
        let toggled = itemManager.toggle(item: Social.imgur, enable: true)
        XCTAssertTrue(toggled)
    
        let items = itemManager.getActiveItems(type: Social.self)
    
        XCTAssert(items.count == 1 && items[0] == Social.imgur)
    }
    
    func testTogglingAnItemTwice() {
        let itemManager = tmpItemManager()
        
        let toggled = itemManager.toggle(item: Social.facebook, enable: true)
        XCTAssertTrue(toggled)
        
        let toggledAgain = itemManager.toggle(item: Social.facebook, enable: false)
        XCTAssertTrue(toggledAgain)
    }
    
    func testTogglingCustomItem() {
        let itemManager = tmpItemManager()
        let customType = Custom.custom(urlFilter: ".*winglejangle.*")
        let toggled = itemManager.toggle(item: customType, enable: true)
        XCTAssertFalse(toggled)
        
        let items = itemManager.getActiveItems(type: Custom.self)
        
        XCTAssert(items.count == 1 && items[0] == customType)
    }
    
}
