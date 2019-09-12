//
//  ResultViewController.swift
//  PersonalityQuiz
//
//  Created by Amirmohamad on 8/29/19.
//  Copyright © 2019 AMR. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    
    @IBOutlet weak var animalTypedLabel: UILabel!
    @IBOutlet weak var desciptionLabel: UILabel!
    
    var response: [Answer]!
    
    func calculatePersonalityResult () {
        animalTypedLabel.text = "err"
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        let responseType = response.map {$0.type}
        for response in responseType {
            let newCount: Int
            if let oldCount = frequencyOfAnswers[response]{
                newCount = oldCount+1
            } else {
                newCount = 1
            }
            frequencyOfAnswers[response] = newCount
            
            let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1}.first!.key
            animalTypedLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
            desciptionLabel.text = mostCommonAnswer.definition
            navigationItem.hidesBackButton = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
    }

}
