//
//  Constants.swift
//  ReservationApp
//
//  Created by Erick Manrique on 4/2/18.
//  Copyright © 2018 Erick Manrique. All rights reserved.
//

import Foundation

enum Api {
    enum ReservationApp {
        static let home = "http://reservationbackend-env.7rpptpwvqj.us-east-1.elasticbeanstalk.com/api"
        static let reservations = home + "/reservations"
        static let findReservationById = home + "/findReservationById"
        static let createReservation = home + "/createReservation"
        static let deleteReservation = home + "/deleteReservation"
    }
}
