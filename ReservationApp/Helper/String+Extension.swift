//
//  String+Extension.swift
//  ReservationApp
//
//  Created by Erick Manrique on 4/2/18.
//  Copyright © 2018 Erick Manrique. All rights reserved.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        get{
            if self.isEmpty{
                return true
            } else{
                return (self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
}
