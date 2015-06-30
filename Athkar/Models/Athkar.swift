//
//  Athkar.swift
//  Athkar
//
//  Created by binaryboy on 6/26/15.
//  Copyright (c) 2015 AhmedHamdy. All rights reserved.
//

import UIKit

class Athkar: NSObject {
    var athkar: String? = ""
    var audio: String? = ""
    var title: String? = ""
    var count: Int? = 0
    var loop:  Int? = 0


    init(athkar: Dictionary<String,AnyObject> ) {
        self.athkar =  athkar["Athkar"] as? String
        self.audio  =  athkar["Audio"] as? String
        self.title  =  athkar["Title"] as? String
        
        
        self.loop   =  athkar["Loop"]?.integerValue
        self.count  =  athkar["Count"]?.integerValue

        
    }
}
