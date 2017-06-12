//
//  AppDelegate.swift
//  Link It
//
//  Created by Dmitry Petukhov on 12/06/2017.
//  Copyright © 2017 dphov Code. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var item : NSStatusItem? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        item = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        item?.image = NSImage(named: "link")
        

        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Link It!", action: #selector(AppDelegate.linkIt), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(AppDelegate.quit), keyEquivalent: ""))

        item?.menu = menu

    }



    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    // www.zappycode.com

    func linkIt() {
        print("WE MADE IT!")
        if let items = NSPasteboard.general().pasteboardItems {
            for item in items {
                for type in item.types {
                    if type == "public.utf8-plain-text" {
                        if let url = item.string(forType: type) {

                            NSPasteboard.general().clearContents()

                            var actualUrl = ""

                            if url.hasPrefix("http://") || url.hasPrefix("https://") {
                                actualUrl = url
                            } else {
                                actualUrl = "http://\(url)"
                            }

                            NSPasteboard.general().setString("<a href=\"\(actualUrl)\">\(url)</a>", forType: "public.html")

                            NSPasteboard.general().setString(url, forType: "public.utf8-plain-text")



                        }
                    }
                }
            }
        }

        printPasteboard()
    }

    func printPasteboard() {
        if let items = NSPasteboard.general().pasteboardItems {
            for item in items {
                for type in item.types {
                    print("Type: \(type)")
                    print("String: \(item.string(forType: type))")
                }
            }
        }

    }
    // www.zappycode.com
    func quit() {
        NSApplication.shared().terminate(self)
    }

}

