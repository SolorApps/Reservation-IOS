//
//  Service.swift
//  ReservationApp
//
//  Created by Erick Manrique on 3/31/18.
//  Copyright © 2018 Erick Manrique. All rights reserved.
//

import Foundation
import Alamofire

class Service {
    
    static let shared = Service()
    
    
    /**
     retrieves reservations
     - parameters:
        - completion: Completion block that will return a Reservation and an error
     */
    func getReservations(completion:@escaping (_ reservations: [Reservation]?, _ error: Error?) -> Void){
        
        Alamofire.request(Api.ReservationApp.reservations, parameters: nil).responseJSON { (response) in
            
            if let error = response.error {
                completion(nil, error)
            } else {
                if let data = response.data {
                    do {
                        // using swift 4 decoder to parse json to object
                        let reservations = try JSONDecoder().decode([Reservation].self, from: data)
                        completion(reservations, nil)
                    } catch DecodingError.keyNotFound(let key, let context) {
                        print("\(key.stringValue) was not found, \(context.debugDescription)")
                    } catch {
                        completion(nil, error)
                    }
                }
                else {
                    completion(nil, nil)
                }
            }
        }
    }
    
    func findReservation(by id:String, completion:@escaping (_ reservation: Reservation?, _ error: Error?) -> Void){
        
        let parameters = [
            "_id":id
        ]
        
        Alamofire.request(Api.ReservationApp.findReservationById, parameters: parameters).responseJSON { (response) in
            
            if let error = response.error {
                completion(nil, error)
            } else {
                if let data = response.data {
                    do {
                        // using swift 4 decoder to parse json to object
                        let reservation = try JSONDecoder().decode(Reservation.self, from: data)
                        completion(reservation, nil)
                    } catch {
                        completion(nil, error)
                    }
                }
                else {
                    completion(nil, nil)
                }
            }
        }
    }
    
    func createReservation(with firstName:String, lastName:String, phoneNumber:String, completion:@escaping (_ reservation: Reservation?, _ error: Error?) -> Void){
        
        let parameters = [
            "first": firstName,
            "last": lastName,
            "phoneNumber": phoneNumber
        ]
        
        Alamofire.request(Api.ReservationApp.createReservation, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            
            if let error = response.error {
                completion(nil, error)
            } else {
                if let data = response.data {
                    do {
                        let reservation = try JSONDecoder().decode(Reservation.self, from: data)
                        completion(reservation, nil)
                    } catch {
                        completion(nil, error)
                    }
                }
                else {
                    completion(nil, nil)
                }
            }
        }
    }

    
    func deleteReservation(with id:String, completion:@escaping (_ response: Response?, _ error: Error?) -> Void){
        
        let parameters = [
            "_id": id
        ]
        
        Alamofire.request(Api.ReservationApp.deleteReservation, method: .delete, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            
            if let error = response.error {
                completion(nil, error)
            } else {
                if let data = response.data {
                    do {
                        let response = try JSONDecoder().decode(Response.self, from: data)
                        completion(response, nil)
                    } catch {
                        completion(nil, error)
                    }
                }
                else {
                    completion(nil, nil)
                }
            }
        }
    }
}
