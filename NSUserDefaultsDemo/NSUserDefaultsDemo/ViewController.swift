//
//  ViewController.swift
//  NSUserDefaultsDemo
//
//  Created by panda zheng on 15/9/13.
//  Copyright (c) 2015年 pandazheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController , NSStreamDelegate{
    
    @IBOutlet weak var iv : UIImageView!
    var input : NSInputStream?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var defaults = NSUserDefaults()
        defaults.setObject("张三", forKey: "name")
        defaults.setInteger(20, forKey: "age")
        defaults.setDouble(1.75, forKey: "height")
        defaults.setBool(true, forKey: "marry")
        
        println("\(NSHomeDirectory())")
        
        defaults.setPersistentDomain(["name":"张三","age":20], forName: "person")

//        self.storePerson()
//        
//        var person = self.getPerson()
//        println("\(person),\(Person.populationCounts)")
        

        
        //NSUserDefaults.standardUserDefaults().synchronize()    //将数据立即存储到plist文件中
        
        var person = Person()
        person.name = "测试的名字张三"
        person.age = 100
        
        var person_1 = Person()
        person_1.name = "测试的名字李四"
        person_1.age = 110
        
        var data = NSMutableData()
        var archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(person, forKey: "zhangsan")
        archiver.encodeObject(person_1, forKey: "lisi")
        archiver.finishEncoding()
        
        var writePath = NSHomeDirectory().stringByAppendingPathComponent("multiPerson.data")
        data.writeToFile(writePath, atomically: true)
        
        var readData = NSData(contentsOfFile: writePath)
        var unarchiver = NSKeyedUnarchiver(forReadingWithData: readData!)
        
        var zhangsan: AnyObject? = unarchiver.decodeObjectForKey("zhangsan") as! Person
        var lisi: AnyObject? = unarchiver.decodeObjectForKey("lisi") as! Person
        
        println("张三:\(zhangsan!),\n,李四:\(lisi!)")
        
        
        //NSStream
        var path = NSBundle.mainBundle().pathForResource("cat", ofType: "jpg")
        input = NSInputStream(fileAtPath: path!)
//        input?.scheduleInRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
//        input?.delegate = self
        input?.open()
        
        var buffer = UnsafeMutablePointer<UInt8>.alloc(1024)
        var length = 1025
        
        var writePicPath = NSHomeDirectory().stringByAppendingPathComponent("cat.jpg")
        var outputStream = NSOutputStream(toFileAtPath: writePicPath, append: true)
        outputStream?.open()
        
        var imageViewData : NSMutableData = NSMutableData()
        while length != -1 && length != 0 {
            length = input!.read(buffer, maxLength: 1024)
            imageViewData.appendBytes(buffer, length: length)
            outputStream?.write(buffer, maxLength: length)
        }
        
        self.iv.image = UIImage(data: imageViewData)
        
        NSLog("%@", NSHomeDirectory())
    }
    
    func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        switch eventCode {
        case NSStreamEvent.OpenCompleted:
            println("OpenCompleted")
        case NSStreamEvent.HasBytesAvailable:
            println("HasBytesAvailable")
            var buffer = UnsafeMutablePointer<UInt8>.alloc(1024)
            var length = 1025
            var imageViewData : NSMutableData = NSMutableData()
            while length != -1 && length != 0 {
                length = input!.read(buffer, maxLength: 1024)
                imageViewData.appendBytes(buffer, length: length)
            }
            
            self.iv.image = UIImage(data: imageViewData)
        case NSStreamEvent.ErrorOccurred:
            println("ErrorOccurred")
        case NSStreamEvent.EndEncountered:
            println("EndEncountered")
        default:
            println("Other")
        }
    }
    
    func archiverObject () {
        var person = Person()
        person.name = "测试的名字张三"
        person.age = 100
        
        var path = NSHomeDirectory().stringByAppendingPathComponent("person.data")
        NSKeyedArchiver.archiveRootObject(person, toFile: path)
        
        var personUnarchiver = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as! Person
        println("\(personUnarchiver)")
    }
    
    
    func firstLunach() -> Bool {
        NSUserDefaults.standardUserDefaults().registerDefaults(["firstLaunch":true])
        var firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("firstLaunch")
        if (firstLaunch) {
            println("程序是第一次启动!")
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "firstLaunch")
        }
        else {
            println("程序不是第一次启动")
        }
        
        return firstLaunch
    }
    
    
    func storePerson() {
        var person = Person()
        person.name = "李四"
        person.age = 45
        person.height = 1.90
        person.marry = true
        var personData = NSKeyedArchiver.archivedDataWithRootObject(person)
        Person.populationCounts = 10
        NSUserDefaults.standardUserDefaults().setObject(personData, forKey:"person")
    }
    
    func getPerson()->Person {
        var personData = NSUserDefaults.standardUserDefaults().objectForKey("person") as! NSData
        var person = NSKeyedUnarchiver.unarchiveObjectWithData(personData) as! Person
        
        return person
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


class Person : NSObject , NSCoding{
    
    static var populationCounts : Double = 60
    
    var name : String?
    var age  : Int32 = 32
    var height : Double = 1.75
    var marry : Bool = true
    
    override init()
    {
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.age = aDecoder.decodeIntForKey("age")
        self.height = aDecoder.decodeDoubleForKey("height")
        self.marry = aDecoder.decodeBoolForKey("marry")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name,forKey: "name")
        aCoder.encodeInt(self.age, forKey: "age")
        aCoder.encodeDouble(self.height, forKey: "height")
        aCoder.encodeBool(self.marry, forKey: "marry")
    }
    
    override var description: String {
        get {
            return NSString(format: "name=%@,age=%d,height=%f,marry=%d", self.name!,self.age,self.height,self.marry) as String
        }
    }
}

