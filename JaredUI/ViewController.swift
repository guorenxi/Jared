//
//  ViewController.swift
//  JaredUI
//
//  Created by Zeke Snider on 4/5/16.
//  Copyright © 2016 Zeke Snider. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var YoutubeSecret: NSTextField!
    @IBOutlet weak var TwitterKey: NSTextField!
    @IBOutlet weak var TwitterSecret: NSTextField!
    
    var defaults: UserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        
        defaults.addObserver(self, forKeyPath: "JaredIsDisabled", options: .new, context: nil)
        updateTouchBarButton()
        
        YoutubeSecret.stringValue = defaults.string(forKey: "YoutubeSecret") ?? "None"
        TwitterKey.stringValue = defaults.string(forKey: "TwitterKey") ?? "None"
        TwitterSecret.stringValue = defaults.string(forKey: "TwitterSecret") ?? "None"
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "JaredIsDisabled" {
            updateTouchBarButton()
        }
    }
    deinit {
        UserDefaults.standard.removeObserver(self, forKeyPath: "JaredIsDisabled")
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window!.title = "Preferences"
    }
    
    func updateTouchBarButton() {
        let defaults = UserDefaults.standard
        if (defaults.bool(forKey: "JaredIsDisabled")) {
            EnableDisableButton.title = "Disable"
        }
        else {
            EnableDisableButton.title = "Enable"
        }
    }
    
    @IBOutlet weak var EnableDisableButton: NSButtonCell!
    
    @IBAction func EnableDisableAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        if (defaults.bool(forKey: "JaredIsDisabled")) {
            defaults.set(false, forKey: "JaredIsDisabled")
        }
        else {
            defaults.set(true, forKey: "JaredIsDisabled")
        }
        
        updateTouchBarButton()

    }
    @IBAction func setButtonPressed(_ sender: AnyObject) {
        defaults.setValue(YoutubeSecret.stringValue, forKey: "YoutubeSecret")
        defaults.setValue(TwitterKey.stringValue, forKey: "TwitterKey")
        defaults.setValue(TwitterSecret.stringValue, forKey: "TwitterSecret")
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

