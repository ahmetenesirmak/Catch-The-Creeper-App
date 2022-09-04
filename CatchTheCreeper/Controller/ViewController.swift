//
//  ViewController.swift
//  CatchTheCreeper
//
//  Created by Ahmet Enes Irmak on 11.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var creeperArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    //Views
    
    @IBOutlet weak var timerText: UILabel!
    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var highscoreText: UILabel!
    
    @IBOutlet weak var creeper1: UIImageView!
    @IBOutlet weak var creeper2: UIImageView!
    @IBOutlet weak var creeper3: UIImageView!
    @IBOutlet weak var creeper4: UIImageView!
    @IBOutlet weak var creeper5: UIImageView!
    @IBOutlet weak var creeper6: UIImageView!
    @IBOutlet weak var creeper7: UIImageView!
    @IBOutlet weak var creeper8: UIImageView!
    @IBOutlet weak var creeper9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreText.text = "Score: \(score)"
        
        let storedHighscore = UserDefaults.standard.object(forKey: "point")
        
        if storedHighscore == nil {
            highScore = 0
            highscoreText.text = "HighScore: \(highScore)"
        }
        
        if let newScore = storedHighscore as? Int {
            highScore = newScore
            highscoreText.text = "HighScore: \(highScore)"
        }
        
        creeper1.isUserInteractionEnabled = true
        creeper2.isUserInteractionEnabled = true
        creeper3.isUserInteractionEnabled = true
        creeper4.isUserInteractionEnabled = true
        creeper5.isUserInteractionEnabled = true
        creeper6.isUserInteractionEnabled = true
        creeper7.isUserInteractionEnabled = true
        creeper8.isUserInteractionEnabled = true
        creeper9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        creeper1.addGestureRecognizer(recognizer1)
        creeper2.addGestureRecognizer(recognizer2)
        creeper3.addGestureRecognizer(recognizer3)
        creeper4.addGestureRecognizer(recognizer4)
        creeper5.addGestureRecognizer(recognizer5)
        creeper6.addGestureRecognizer(recognizer6)
        creeper7.addGestureRecognizer(recognizer7)
        creeper8.addGestureRecognizer(recognizer8)
        creeper9.addGestureRecognizer(recognizer9)
        
        creeperArray = [creeper1,creeper2,creeper3,creeper4,creeper5,creeper6,creeper7,creeper8,creeper9]
        
        counter = 10
        timerText.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideCreeper), userInfo: nil, repeats: true)
        
        hideCreeper()
    }
    
    
    @objc func hideCreeper() {
        
        for creeper in creeperArray {
            creeper.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(creeperArray.count - 1)))
        creeperArray[random].isHidden = false
        
    }
    
    
    @objc func increaseScore() {
        score += 1
        scoreText.text = "Score: \(score)"
    }
    
    
    @objc func countDown() {
        
        timerText.text = "\(counter)"
        counter -= 1
        
        if counter == -1 {
            timer.invalidate()
            hideTimer.invalidate()
            
            timerText.text = "0"
            
            for creeper in creeperArray {
                creeper.isHidden = true
            }
            
            //High Score
            
            if self.score > self.highScore {
                
                self.highScore = self.score
                self.highscoreText.text = "Highscore: \(highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "point")
                
            }
            
            
            
            //Alert
            
            let alert = UIAlertController(title: "Time", message: "Time is up!", preferredStyle: UIAlertController.Style.alert)
            
            let alertButton = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil)
            let alertButton2 = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                
                //replay function
                
                self.score = 0
                self.scoreText.text = "Score: \(self.score)"
                
                self.counter = 10
                self.timerText.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideCreeper), userInfo: nil, repeats: true)
                
            }
            
            
            alert.addAction(alertButton)
            alert.addAction(alertButton2)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    

}

