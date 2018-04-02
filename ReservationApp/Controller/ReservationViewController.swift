//
//  ReservationViewController.swift
//  ReservationApp
//
//  Created by Erick Manrique on 3/31/18.
//  Copyright © 2018 Erick Manrique. All rights reserved.
//

import UIKit

class ReservationViewController: UIViewController {

    // MARK:- IBOutlet
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    // MARK:- Variables
    var reservation: Reservation!
    
    // MARK:- Live Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Reservation"
        fullNameLabel.text = reservation.fullName
        phoneNumberLabel.text = reservation.phoneNumber
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
