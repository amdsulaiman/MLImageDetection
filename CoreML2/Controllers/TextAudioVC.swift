//
//  TextAudioVC.swift
//  CoreML2
//
//  
//

import UIKit
import AVFoundation

class TextAudioVC: UIViewController,AVSpeechSynthesizerDelegate {

    let speechSynthesizer = AVSpeechSynthesizer()
    var isRobotOn = false
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var inputTxt: UITextField!
    @IBOutlet weak var playPauseRefBtn: UIButton!
    var arrSpeechCount = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "eight", "nine", "ten"]
    var count : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        speechSynthesizer.delegate = self

        
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        inputTxt.text = utterance.speechString
        }
        
        func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
            speechSynthesizer.stopSpeaking(at: .word)
            
                     count += 1
                     if inputTxt.text?.isEmpty == false{
                        let speechUtterance = AVSpeechUtterance(string: inputTxt.text!)
                        DispatchQueue.main.async {
                            self.speechSynthesizer.speak(speechUtterance)
                        }
                    } else {
                        count = 0
                        playPauseRefBtn.isSelected = false
                    }
        }
    
    @IBAction func PlayBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
                
                if sender.isSelected {
                    Start()
                    playPauseRefBtn.setImage(#imageLiteral(resourceName: "icons8-pause-button-100"), for: .normal)
                }else {
                    Pause()
                    playPauseRefBtn.setImage(#imageLiteral(resourceName: "icons8-circled-play-100"), for: .normal)
                }
    }
    func Pause()  {
            speechSynthesizer.pauseSpeaking(at: .immediate)
        }
    func Start()  {
            // Code to start speech
            if speechSynthesizer.isSpeaking {
                speechSynthesizer.stopSpeaking(at: .immediate)
            } else {
                let speechUtterance = AVSpeechUtterance(string: inputTxt.text!)
                DispatchQueue.main.async {
                    self.speechSynthesizer.speak(speechUtterance)

                }
            }
        }

}
//icons8-circled-play-100
//icons8-pause-button-100
