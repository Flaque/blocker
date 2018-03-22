//
//  ContentBlockerRequestHandler.swift
//  blocker-extension
//
//  Created by Evan Conrad on 3/20/18.
//  Copyright © 2018 Evan Conrad. All rights reserved.
//

import UIKit
import MobileCoreServices

class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {

    func beginRequest(with context: NSExtensionContext) {
        
        
        guard
            let baseURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.webblocker"),
            let attachment = NSItemProvider(contentsOf: baseURL.appendingPathComponent("CustomBlockerList.json", isDirectory: false))
        else {
            print("Could not read CustomBlockerList.json")
            return
        }
        
//        let baseURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.webblocker")!
//        let attachment = NSItemProvider(contentsOf: baseURL.appendingPathComponent("CustomBlockerList.json", isDirectory: false))!
        
        let item = NSExtensionItem()
        item.attachments = [attachment]
        context.completeRequest(returningItems: [item], completionHandler: nil)
    }
    
}
