//
//  ViewController.swift
//  SandBoxDemo
//
//  Created by panda zheng on 15/9/13.
//  Copyright (c) 2015年 pandazheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let homepath = NSHomeDirectory()
        println("homepath = \(homepath)")
        
        
        let libpath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        println("libpath = \(libpath)")
        
        let docpath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        println("docpath = \(docpath)")
        
        let temppath = NSTemporaryDirectory()
        println("temppath = \(temppath)")
        
        let test = "~".stringByAppendingPathComponent("Documents").stringByAppendingPathComponent("test")
        println("test = \(test)")
        
        println("\(test)===========>代表的文件目录\(test.stringByStandardizingPath)")
        
        var error : NSError?
        "pandazheng".writeToFile(test.stringByStandardizingPath, atomically: true, encoding: NSUTF8StringEncoding, error: &error)
        if (nil != error) {
            println("\(error!)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

