//
//  Reservation.swift
//  ReservationApp
//
//  Created by Erick Manrique on 3/31/18.
//  Copyright © 2018 Erick Manrique. All rights reserved.
//

import Foundation

class Reservation: Decodable {
    
    var _id: String?
    var name: User?
    var phoneNumber: String?
    var fullName: String?
    
}

class User: Decodable{
    var first: String?
    var last: String?
    
}
