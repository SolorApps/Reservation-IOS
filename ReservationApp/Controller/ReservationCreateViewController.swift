//
//  ReservationCreateViewController.swift
//  ReservationApp
//
//  Created by Erick Manrique on 4/2/18.
//  Copyright © 2018 Erick Manrique. All rights reserved.
//

import UIKit

class ReservationCreateViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Create Reservation"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createReservation(_ sender: UIButton) {
        createReservationRequest()
    }
    
    
    func createReservationRequest() {
        
        guard let firstName = firstNameTextField.text, !firstName.isEmptyOrWhitespace else{
            Alert.showBasic(title: "Required Fields", message: "Missing required fields", vc: self)
            return
        }
        guard let lastName = lastNameTextField.text, !lastName.isEmptyOrWhitespace else{
            Alert.showBasic(title: "Required Fields", message: "Missing required fields", vc: self)
            return
        }
        guard let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmptyOrWhitespace else{
            Alert.showBasic(title: "Required Fields", message: "Missing required fields", vc: self)
            return
        }
        
        guard phoneNumber.count == 10 else {
            Alert.showBasic(title: "Invalid Phone Number", message: "Enter a valid phone number", vc: self)
            return
        }
        
        Service.shared.createReservation(with: firstName, lastName: lastName, phoneNumber: phoneNumber) { (reservation, error) in
            DispatchQueue.main.async { [weak self] in
                if error != nil {
                    Alert.showNetworkError(on: self!)
                } else {
                    if let reservation = reservation {
                        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "refreshData"), object: nil, userInfo: ["reservation": reservation])
                        self?.navigationController?.popViewController(animated: true)
                    } else {
                        Alert.showBasic(title: "No Data", message: "No data was received", vc: self!)
                    }
                }
            }
        }
    }

}
