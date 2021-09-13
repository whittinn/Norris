//
//  ViewController.swift
//  Norris
//
//  Created by Nathaniel Whittington on 9/8/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        valueLabel.text = String(Int(slider.value))
      
    }

    @IBAction func nextQuestion(_ sender: UIButton) {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else {
            fatalError("Error getting chuck Norris URL")
        }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dict = json as? [String: Any] {
                        //FOR SINGLE VALUES
                        if let values = dict["value"] as? String{
                            DispatchQueue.main.async {
                                self.label.text = values
                              
                            }
                      
                        }
                    }
                }catch{
                    print(error)
                }
            }
        }.resume()
        //RESET SLIDER AND LABEL VALUE
        slider.value = 0
        valueLabel.text = String(Int(slider.value))

        
    }
    
    @IBAction func sliderDidMove(_ sender: UISlider) {
        valueLabel.text = String(Int(sender.value))
    }
}

