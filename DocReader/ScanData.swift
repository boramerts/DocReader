//
//  ScanData.swift
//  DocReader
//
//  Created by Bora Mert on 2.12.2023.
//

import Foundation

struct ScanData : Identifiable{
    var id = UUID()
    
    let content:String
    
    init(content:String) {
        self.content = content
    }
}
