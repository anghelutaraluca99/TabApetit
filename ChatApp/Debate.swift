//
//  Debate.swift
//  ChatApp
//
//  Created by Raluca Angheluta on 17/07/2017.
//  Copyright © 2017 Raluca Angheluta. All rights reserved.
//

import Foundation

class Debate : NSObject {
    var id : String!
    var placeName: String!
    var placeLat: CLLocationDegrees!
    var placeLong: CLLocationDegrees!
    var date: String!
    var time: String!
    var theme : String!
    var numberOfParticipants : Int!
    
    override init() {
        placeName = "No place selected"
        placeLat = 0
        placeLong = 0
        date = "01/01/01"
        time = "00:00"
        theme = "No theme chosen"
        numberOfParticipants = 1
    }
}
