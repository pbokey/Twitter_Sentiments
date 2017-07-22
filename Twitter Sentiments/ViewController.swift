//
//  ViewController.swift
//  Twitter Sentiments
//
//  Created by Pranav Bokey on 7/21/17.
//  Copyright © 2017 Pranav Bokey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var keywordInput: UITextField!
    
    @IBOutlet weak var positiveLabel: UILabel!
    
    @IBOutlet weak var neutralLabel: UILabel!
    
    @IBOutlet weak var negativeLabel: UILabel!

    
    @IBAction func submitBtn(_ sender: Any) {
        if let keyword = self.keywordInput.text {
            let word = keyword.replacingOccurrences(of: " ", with: "_").lowercased()
            analyzeSentiments(keyword: word)
        }
    }
    
    func analyzeSentiments(keyword: String) {
        var dict: [String: String] = [:]
        var positive = ""
        var neutral = ""
        var negative = ""
        
        guard let url = URL(string: "https://still-castle-73273.herokuapp.com/getSentiment?keyword=\(keyword)") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            do {
                let data = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: String]
                dict = data
                print(dict)
                positive = data["positive"]!
                neutral = data["neutral"]!
                negative = data["negative"]!
            } catch {
                print(error)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // in half a second...
                self.positiveLabel.text = "Positive Tweets: \(positive)"
                self.neutralLabel.text = "Neutral Tweets: \(neutral)"
                self.negativeLabel.text = "Negative Tweets: \(negative)"
            }
        }.resume()
        
    }
    
    func setup() {
        self.positiveLabel.text = "Positive Tweets"
        self.neutralLabel.text = "Neutral Tweets"
        self.negativeLabel.text = "Negative Tweets"
        
        self.positiveLabel.textColor = UIColor.green
        self.neutralLabel.textColor = UIColor.white
        self.negativeLabel.textColor = UIColor.red
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        setup()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
