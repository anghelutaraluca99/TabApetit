//
//  Debate.swift
//  ChatApp
//
//  Created by Raluca Angheluta on 17/07/2017.
//  Copyright © 2017 Raluca Angheluta. All rights reserved.
//

import Foundation
import GooglePlaces

class Debate : NSObject {
    var place : GMSPlace!
    var theme : String!
    var participants : [User]!
    
    override init() {
        place = GMSPlace.init()
        theme = "General"
    }
}
