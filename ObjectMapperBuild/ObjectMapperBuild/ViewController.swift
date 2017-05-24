//
//  ViewController.swift
//  ObjectMapperBuild
//
//  Created by SunnyZhang on 2017/5/24.
//  Copyright © 2017年 Sunny. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var jsonTextView: NSTextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "json"

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
   //MARK: ---- click ----
    @IBAction func jsonToModelClick(_ sender: Any) {
        var jsonValue : String! = self.jsonTextView.string ?? "";
//        jsonValue = "[\"abc\":\"def\"]"
        self.jsonToModel(jsonValue: jsonValue);
        
    }
}

//MARK: ---- private method ----

extension ViewController {
    fileprivate  func jsonToModel(jsonValue: String){
        
        self.testJson();
        return;
        
        if !(JSONSerialization.isValidJSONObject(jsonValue )) {
            print("无效的json")
            return ;
        }
        
        //利用自带的json库转换成Data
        //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
        let data = try? JSONSerialization.data(withJSONObject: jsonValue, options: [])
//        let dictJson = try? JSONSerialization.jsonObject(with: data, options: <#T##JSONSerialization.ReadingOptions#>)
        let dictJson = try? JSONSerialization.jsonObject(with: data!, options:.allowFragments);
        print("dictjson = \(String(describing: dictJson))")

    }
    
    
    //测试json
    func testJson() {
        var string = "[{\"ID\":1,\"Name\":\"元台禅寺\",\"LineID\":1},{\"ID\":2,\"Name\":\"田坞里山塘\",\"LineID\":1},{\"ID\":3,\"Name\":\"滴水石\",\"LineID\":1}]"
        string = "{\"ID\":1,\"Name\"}"
        
        let data = string.data(using: String.Encoding.utf8)
        
        let jsonArr = try! JSONSerialization.jsonObject(with: data!,
                                                        options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: Any]]
        
        print("记录数：\(jsonArr.count)")
        for json in jsonArr {
            print("ID：", json["ID"]!, "    Name：", json["Name"]!)
        }
    }
    
    
}


