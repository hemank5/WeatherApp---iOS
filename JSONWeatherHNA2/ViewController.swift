//
//  ViewController.swift
//  JSONWeatherHNA2
//
//  Created by Hemank Narula on 4/29/17.
//  Copyright © 2017 Hemank Narula. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet var cityTextField: UITextField!
    
    
    @IBAction func submit(_ sender: Any) {
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + cityTextField.text!.replacingOccurrences(of: " ", with: "%20") + ",uk&appid=80ac88033ec4757eb3d617f4b003ad42") {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                
                print(error as Any)
                
            } else {
                
                if let urlContent = data {
                    
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject // Added "as anyObject" to fix syntax error in Xcode 8 Beta 6
                        
                        print(jsonResult)
                        
                        print(jsonResult["name"])
                        
                        if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                            
                            DispatchQueue.main.sync(execute: {
                                
                                self.resultLabel.text = description
                                
                            })
                            
                        }
                       
                        
                    } catch {
                        
                        print("JSON Processing Failed")
                        
                    }
                    
                }
                
                
            }
            
            
            }
            
            task.resume()
            
        } else {
            
            resultLabel.text = "Couldn't find weather for that city, please try another."
            tempLabel.text = "Couldn't find weather for that city, please try another."
            
        }
        
    }
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

