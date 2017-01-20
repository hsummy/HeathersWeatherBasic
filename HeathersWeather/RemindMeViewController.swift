//
//  RemindMeViewController.swift
//  HeathersWeather
//
//  Created by HSummy on 1/19/17.
//  Copyright © 2017 HSummy. All rights reserved.
//

import UIKit
//adding UserNotifications to enhance app. adding UITextFieldDelegate.
import UserNotifications

class RemindMeViewController: UIViewController, UITextFieldDelegate
{

   //adding outlets for reminder feature
    @IBOutlet weak var activityReminderTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
//adding functions for textfield and picker
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func pickerFormatValueChanged(_ sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
        case 0:
            datePicker.datePickerMode = .dateAndTime
        case 1:
            datePicker.datePickerMode = .countDownTimer
        default: break
        }
    }
    
    @IBAction func setReminderButtonTapped(_ sender: UIButton)
    {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        //        content.subtitle = "subtitle"
        content.body = activityReminderTextField.text!
        content.badge = 1
        content.sound = UNNotificationSound.default()
        
        let request: UNNotificationRequest
        if datePicker.datePickerMode == .dateAndTime
        {
            let trigger = determineDateTrigger()
            request = UNNotificationRequest(identifier: "Reminder", content: content, trigger: trigger)
        }
        else
        {
            let trigger = determineCountdownTrigger()
            request = UNNotificationRequest(identifier: "Reminder", content: content, trigger: trigger)
        }
        
        let center = UNUserNotificationCenter.current()
        center.add(request) {
            error in
            if let theError = error
            {
                print(theError.localizedDescription)
            }
            else
            {
                print("user notification scheduled successfully.")
            }
        }
        
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
        
       // let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func determineDateTrigger() -> UNCalendarNotificationTrigger
    {
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: datePicker.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        return trigger
    }
    
    func determineCountdownTrigger() -> UNTimeIntervalNotificationTrigger
    {
        return UNTimeIntervalNotificationTrigger(timeInterval: datePicker.countDownDuration, repeats: false)
    }

    
    

    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}//end of RemindMeViewControll class

