//
//  ViewController.swift
//  NSFileManagerDemo
//
//  Created by panda zheng on 15/9/13.
//  Copyright (c) 2015年 pandazheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSLog("%@", NSHomeDirectory())
        
        //创建文件
        self.createFile()
        //移动文件
        var testPath = NSHomeDirectory().stringByAppendingPathComponent("string.txt")
        var destation = NSHomeDirectory().stringByAppendingPathComponent("test").stringByAppendingPathComponent("string.txt")
        NSFileManager.defaultManager().moveItemAtPath(testPath, toPath: destation, error: nil)
        //拷贝文件
        var copyPath = NSHomeDirectory().stringByAppendingPathComponent("test").stringByAppendingPathComponent("string2.txt")
        NSFileManager.defaultManager().copyItemAtPath(destation, toPath: copyPath, error: nil)
        //删除文件
        NSFileManager.defaultManager().removeItemAtPath(copyPath, error: nil)
        //查找文件
        var finds = NSFileManager.defaultManager().contentsOfDirectoryAtPath(NSHomeDirectory().stringByAppendingPathComponent("test"), error: nil)
        println(finds!)
        
        
        var findUrls = NSFileManager.defaultManager().contentsOfDirectoryAtURL(NSURL(string: NSHomeDirectory().stringByAppendingPathComponent("test"))!, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions.SkipsHiddenFiles, error: nil)
        println("\(findUrls!)")
        
        var findUrl = findUrls?.first as! NSURL
        
        var urlPath : AnyObject? = nil
        findUrl.getResourceValue(&urlPath, forKey: kCFURLPathKey as! String, error: nil)
        println("\(urlPath!)")
        //检测文件
        findFile()
    }
    
    func findFile() {
        var exist = NSFileManager.defaultManager().fileExistsAtPath(NSHomeDirectory().stringByAppendingPathComponent("test").stringByAppendingPathComponent("string.txt"))
        println("文件存在:\(exist)")
    }
    
    func createFile() {
        var filePath = NSHomeDirectory().stringByAppendingPathComponent("text.txt")
        var fileManager = NSFileManager.defaultManager()
        fileManager.createFileAtPath(filePath, contents: nil, attributes: nil)
        
        var attributes = fileManager.attributesOfItemAtPath(filePath, error: nil)
        println("文件属性: \(attributes!)")
        
        
        var string: NSString = "测试"
        var testPath = NSHomeDirectory().stringByAppendingPathComponent("string.txt")
        string.writeToFile(testPath, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
        
        var imagePath = NSHomeDirectory().stringByAppendingPathComponent("image.jpg")
        var catImage : UIImage = UIImage(named: "cat.jpg")!
        var catImageData : NSData = UIImageJPEGRepresentation(catImage, 1.0)
        catImageData.writeToFile(imagePath, atomically: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

