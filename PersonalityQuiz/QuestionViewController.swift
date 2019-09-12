//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Amirmohamad on 8/29/19.
//  Copyright © 2019 AMR. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    //Variables
    var usersAnswers: [Answer] = []
    
    
    //Outlets
    @IBOutlet weak var questiongLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multipleAnswerSwitch1: UISwitch!
    @IBOutlet weak var multipleAnswerSwitch2: UISwitch!
    @IBOutlet weak var multipleAnswerSwitch3: UISwitch!
    @IBOutlet weak var multipleAnswerSwitch4: UISwitch!
    @IBOutlet weak var multipleLabel1: UILabel!
    @IBOutlet weak var multipleLabel2: UILabel!
    @IBOutlet weak var multipleLabel3: UILabel!
    @IBOutlet weak var multipleLabel4: UILabel!
    
    @IBOutlet weak var sliderStackView: UIStackView!
    @IBOutlet weak var rangedSlider: UISlider!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    
    @IBOutlet weak var bottomProgressBar: UIProgressView!
    
    func nextQuestion() {
        questionIndex+=1
        
        if questionIndex < question.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultSegue", sender: nil)
        }
    }
    
    //Actions
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = question[questionIndex].answer
        
        switch sender {
        case singleButton1:
            usersAnswers.append(currentAnswers[0])
        case singleButton2:
            usersAnswers.append(currentAnswers[1])
        case singleButton3:
            usersAnswers.append(currentAnswers[2])
        case singleButton4:
            usersAnswers.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = question[questionIndex].answer
        let index = Int(round(rangedSlider.value * Float (currentAnswers.count - 1)))
        usersAnswers.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = question[questionIndex].answer
        
        if multipleAnswerSwitch1.isOn{
            usersAnswers.append(currentAnswers[0])
        }
        if multipleAnswerSwitch2.isOn{
            usersAnswers.append(currentAnswers[1])
        }
        if multipleAnswerSwitch3.isOn{
            usersAnswers.append(currentAnswers[2])
        }
        if multipleAnswerSwitch4.isOn{
            usersAnswers.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    //Question variable
    var question: [Question] = [
        Question(text: "Which food do you like the most?", type: .single, answer: [
            Answer(text: "Steak", type: .dog),
            Answer(text: "Fish", type: .cat),
            Answer(text: "Carrot", type: .rabbit),
            Answer(text: "Corn", type: .turtle)
            ]),
        Question (text: "Which acitivities do you like most?", type: .multiple, answer: [
            Answer(text: "Swimming", type: .turtle),
            Answer(text: "Sleeping", type: .cat),
            Answer(text: "Cuddling", type: .rabbit),
            Answer(text: "Eating", type: .dog)
            ]),
        Question(text: "How much do you enjoy car rides?", type: .ranged, answer: [
            Answer(text: "I dislike them", type: .cat),
            Answer(text: "I get little nervous", type: .rabbit),
            Answer(text: "I barely notice them", type: .turtle),
            Answer(text: "I love them", type: .dog)
            ])
    ]
    
    //Index variable
    var questionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    func updateSingleStackView(using answer: [Answer]) {
        singleStackView.isHidden = false
        
        singleButton1.setTitle(answer[0].text, for: .normal)
        singleButton2.setTitle(answer[1].text, for: .normal)
        singleButton3.setTitle(answer[2].text, for: .normal)
        singleButton4.setTitle(answer[3].text, for: .normal)
    }
    
    func updateMultipleStackView (using answer: [Answer]) {
        multipleStackView.isHidden = false
        
        multipleAnswerSwitch1.isOn = false
        multipleAnswerSwitch2.isOn = false
        multipleAnswerSwitch3.isOn = false
        multipleAnswerSwitch4.isOn = false
        
        multipleLabel1.text = answer[0].text
        multipleLabel2.text = answer[1].text
        multipleLabel3.text = answer[2].text
        multipleLabel4.text = answer[3].text
    }
    
    func updateSliderStackView(using answer: [Answer]) {
        sliderStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answer.first?.text
        rangedLabel2.text = answer.last?.text
        
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        sliderStackView.isHidden = true
        
        navigationItem.title = "Question #\(questionIndex+1)"
        
        
        let currentQuestion = question[questionIndex]
        let currentAnswer = currentQuestion.answer
        
        questiongLabel.text = currentQuestion.text
        
        let progressBarProgress = Float(questionIndex/question.count)
        bottomProgressBar.setProgress(progressBarProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStackView(using: currentAnswer)
        case .multiple:
            updateMultipleStackView(using: currentAnswer)
        case .ranged:
            updateSliderStackView(using: currentAnswer)
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ResultSegue" {
            let resultViewController = segue.destination as! ResultViewController
            resultViewController.response = usersAnswers
        }
    }
    
}

