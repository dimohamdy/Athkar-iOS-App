//
//  MenuItem.swift
//  Athkar
//
//  Created by binaryboy on 6/26/15.
//  Copyright (c) 2015 AhmedHamdy. All rights reserved.
//

import UIKit



class MenuItem: NSObject {
    
    
     var name: String? = ""
     var page: String? = ""
     var color: String? = ""
    init(menu: Dictionary<String,String> ) {
        self.page =  menu["Page"]
        self.name =  menu["Name"]
        self.color =  menu["Color"]

    }
    
}
