//
//  BlockerTests.swift
//  blockerTests
//
//  Created by Evan Conrad on 3/23/18.
//  Copyright © 2018 Evan Conrad & Rudy Bermudez. All rights reserved.
//

import XCTest

class BlockerTests: XCTestCase {
    
    var itemManager : BlockerItemManager?
    var tmpdir : URL?

    override func setUp() {
        super.setUp()
        
        tmpdir = FileManager.default.temporaryDirectory
        let fileManager = BlockerFileManager(baseURL: FileManager.default.temporaryDirectory)
        itemManager = BlockerItemManager(fileManager: fileManager)
        fileManager.createEmptyBlockerFile()
    }
    
    override func tearDown() {
        super.tearDown()
    
        do {
            try FileManager.default.removeItem(at: tmpdir!)
        } catch let error  {
            print(error.localizedDescription)
        }
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
        
        let toggled = itemManager!.toggle(item: Social.imgur, enable: true)
        XCTAssertTrue(toggled)
        
        let items = itemManager!.getActiveItems(type: Social.self)

        XCTAssert(items.count == 1)
        XCTAssert(items[0] == Social.imgur)
    }
    
    func testTogglingAnItemTwice() {
        
        let toggled = itemManager!.toggle(item: Social.facebook, enable: false)
        XCTAssertTrue(toggled)
        
        let toggledAgain = itemManager!.toggle(item: Social.facebook, enable: true)
        XCTAssertTrue(toggledAgain)
    }
    
}
