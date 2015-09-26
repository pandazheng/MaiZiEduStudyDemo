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
        do {
            try NSFileManager.defaultManager().moveItemAtPath(testPath, toPath: destation)
        } catch _ {
        }
        //拷贝文件
        var copyPath = NSHomeDirectory().stringByAppendingPathComponent("test").stringByAppendingPathComponent("string2.txt")
        do {
            try NSFileManager.defaultManager().copyItemAtPath(destation, toPath: copyPath)
        } catch _ {
        }
        do {
            //删除文件
            try NSFileManager.defaultManager().removeItemAtPath(copyPath)
        } catch _ {
        }
        //查找文件
        var finds = try? NSFileManager.defaultManager().contentsOfDirectoryAtPath(NSHomeDirectory().stringByAppendingPathComponent("test"))
        print(finds!)
        
        
        var findUrls = try? NSFileManager.defaultManager().contentsOfDirectoryAtURL(NSURL(string: NSHomeDirectory().stringByAppendingPathComponent("test"))!, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions.SkipsHiddenFiles)
        print("\(findUrls!)")
        
        var findUrl = findUrls?.first as! NSURL
        
        var urlPath : AnyObject? = nil
        do {
            try findUrl.getResourceValue(&urlPath, forKey: kCFURLPathKey as! String)
        } catch _ {
        }
        print("\(urlPath!)")
        //检测文件
        findFile()
    }
    
    func findFile() {
        let exist = NSFileManager.defaultManager().fileExistsAtPath(NSHomeDirectory().stringByAppendingPathComponent("test").stringByAppendingPathComponent("string.txt"))
        print("文件存在:\(exist)")
    }
    
    func createFile() {
        var filePath = NSHomeDirectory().stringByAppendingPathComponent("text.txt")
        var fileManager = NSFileManager.defaultManager()
        fileManager.createFileAtPath(filePath, contents: nil, attributes: nil)
        
        var attributes = try? fileManager.attributesOfItemAtPath(filePath)
        print("文件属性: \(attributes!)")
        
        
        var string: NSString = "测试"
        var testPath = NSHomeDirectory().stringByAppendingPathComponent("string.txt")
        do {
            try string.writeToFile(testPath, atomically: true, encoding: NSUTF8StringEncoding)
        } catch _ {
        }
        
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

