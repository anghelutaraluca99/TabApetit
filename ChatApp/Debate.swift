//
//  Debate.swift
//  ChatApp
//
//  Created by Raluca Angheluta on 17/07/2017.
//  Copyright © 2017 Raluca Angheluta. All rights reserved.
//

import Foundation

class Debate : NSObject {
    var placeName: String!
    var placeLat: CLLocationDegrees!
    var placeLong: CLLocationDegrees!
    var date: Date!
    var time: Date!
    var theme : String!
    var numberOfParticipants : Int!
    
    override init() {
        placeName = "No place selected"
        placeLat = 0
        placeLong = 0
        date = Date.init()
        time = Date.init()
        theme = "No theme chosen"
        numberOfParticipants = 1
    }
}
