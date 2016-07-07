//
//  ViewController.swift
//  NVHgoBowling
//
//  Created by Hùng Nguyễn  on 7/6/16.
//  Copyright © 2016 MobileSoftware. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var background = UIImageView()
    var bowlingBall = UIImageView()
    var ballRadious = CGFloat()
    var radians = CGFloat()
    
    var audioSoundTrack = AVAudioPlayer()
    var audioGoal = AVAudioPlayer()
    var audioWistle = AVAudioPlayer()
    
    var direction = "Up"
    let timeToPlaySoundTrack =  NSTimer()
    var timeToPlayGoalSound = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBowlingFloor()
        addBowlingBall()
        playRefereeWhistleSound()
        playSoundTrack()
//        playSoundGoal()
        

//        audioGoal.delegate = self
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: #selector(rollBowling), userInfo: nil, repeats: true)
      }
    
    
    func addBowlingFloor() {
        background = UIImageView(image: UIImage(named: "football_stadium.jpg"))
        
        background.frame = self.view.bounds
        background.contentMode = .ScaleAspectFill
        
        self.view.addSubview(background)
    }
    
    
    func addBowlingBall()
    {
        // lay ra width + height main screen
        let  mainViewSize = self.view.bounds.size
        
        bowlingBall = UIImageView(image: UIImage(named: "euro-2016-offcial-match-soccer-ball-ac5415-thumb.png"))
        ballRadious = 25.0
        bowlingBall.center = CGPointMake(mainViewSize.width * 0.5, mainViewSize.height * 0.5)
        
        self.view.addSubview(bowlingBall)
        
    }
    
    func rollBowling()
    {
        let deltaAngle : CGFloat = 0.1
        radians = radians + deltaAngle
        bowlingBall.transform = CGAffineTransformMakeRotation(radians)
        
        switch direction {
        case "Up":
            self.bowlingBall.center = CGPointMake(self.bowlingBall.center.x, self.bowlingBall.center.y - self.ballRadious * deltaAngle)
                if self.bowlingBall.center.y - self.ballRadious <= 0 {
                direction = "DownRightTop"
                self.playSoundGoal()
                audioWistle.play()
            }
        case "DownRightTop":
            self.bowlingBall.center = CGPointMake(self.bowlingBall.center.x + self.ballRadious * deltaAngle, self.bowlingBall.center.y + self.ballRadious * deltaAngle)
            if self.bowlingBall.center.x + self.ballRadious >= self.view.bounds.size.width {
                direction = "DownLeftBot"
            }
        case "DownLeftBot":
            self.bowlingBall.center = CGPointMake(self.bowlingBall.center.x - self.ballRadious * deltaAngle, self.bowlingBall.center.y + self.ballRadious * deltaAngle)
            if self.bowlingBall.center.x - self.ballRadious <= 0 {
                direction = "DownRightBot"
            }
        case "DownRightBot":
            self.bowlingBall.center = CGPointMake(self.bowlingBall.center.x + self.ballRadious * deltaAngle, self.bowlingBall.center.y + self.ballRadious * deltaAngle)
            if self.bowlingBall.center.y + self.ballRadious >= self.view.bounds.size.height {
                direction = "UpRightBot"
                self.playSoundGoal()
                audioWistle.play()
            }
        case "UpRightBot":
            self.bowlingBall.center = CGPointMake(self.bowlingBall.center.x + self.ballRadious * deltaAngle, self.bowlingBall.center.y - self.ballRadious * deltaAngle)
            if self.bowlingBall.center.x + self.ballRadious >= self.view.bounds.size.width {
                direction = "UpLeftTop"
            }
        case "UpLeftTop":
            self.bowlingBall.center = CGPointMake(self.bowlingBall.center.x - self.ballRadious * deltaAngle, self.bowlingBall.center.y - self.ballRadious * deltaAngle)
            if self.bowlingBall.center.x - self.ballRadious <= 0 {
                direction = "UpRightTop"
            }
        case "UpRightTop":
            self.bowlingBall.center = CGPointMake(self.bowlingBall.center.x + self.ballRadious * deltaAngle, self.bowlingBall.center.y - self.ballRadious * deltaAngle)
            if self.bowlingBall.center.y - self.ballRadious <= 0 {
                direction = "DownToMiddle"
                self.playSoundGoal()
                audioWistle.play()
            }
         case "DownToMiddle":
            self.bowlingBall.center = CGPointMake(self.bowlingBall.center.x , self.bowlingBall.center.y +  self.ballRadious * deltaAngle)
            if self.bowlingBall.center.y +  self.ballRadious * deltaAngle >= self.view.bounds.size.height * 0.5 {
                direction = "RollToRight"
            }
         case "RollToRight":
            self.bowlingBall.center = CGPointMake(self.bowlingBall.center.x + self.ballRadious * deltaAngle, self.bowlingBall.center.y)
            if self.bowlingBall.center.x + self.ballRadious  >= self.view.bounds.size.width {
                direction = "RollToLeft"
                audioWistle.play()
            }
         case "RollToLeft":
            self.bowlingBall.center = CGPointMake(self.bowlingBall.center.x - self.ballRadious * deltaAngle, self.bowlingBall.center.y)
            if self.bowlingBall.center.x - self.ballRadious <= 0 {
                direction = "RollToMiddle"
                audioWistle.play()
            }
         case "RollToMiddle":
            self.bowlingBall.center = CGPointMake(self.bowlingBall.center.x + self.ballRadious * deltaAngle, self.bowlingBall.center.y)
            if self.bowlingBall.center.x + self.ballRadious * deltaAngle >= self.view.bounds.size.width * 0.5 {
                direction = "Up"
            }
//         case "DownRightTop":
//            self.bowlingBall.center = CGPointMake(self.bowlingBall.center.x + self.ballRadious * deltaAngle, self.bowlingBall.center.y + self.ballRadious * deltaAngle )
//            if self.bowlingBall.center.x + self.ballRadious >= self.view.bounds.size.width {
//                direction = "DownLeftBot"
//            }
//         case "DownLeftBot":
//            self.bowlingBall.center = CGPointMake(self.bowlingBall.center.x, self.bowlingBall.center.y + self.ballRadious * deltaAngle)
//            if self.bowlingBall.center.y + self.ballRadious >= self.view.bounds.size.height {
//                direction = "MoveOnBotBoder"
//            }
//         case "MoveOnBotBoder":
//            self.bowlingBall.center = CGPointMake(self.bowlingBall.center.x - self.ballRadious * deltaAngle, self.bowlingBall.center.y)
//            if self.bowlingBall.center.x == self.view.bounds.size.width / 2 {
//                direction = "Up"
//            }
        default:
            break
        }
    }

//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        audioSoundTrack.play()
//    }
    
    func playSoundTrack()
    {
        // creat fileSoundPath
        let fileSoundTrackPath = NSBundle.mainBundle().pathForResource("196463__paulw2k__football-crowd-cheer-jeers", ofType: "wav")
        let url = NSURL(fileURLWithPath: fileSoundTrackPath!)
        // play sound
        audioSoundTrack = try! AVAudioPlayer(contentsOfURL: url)
        audioSoundTrack.prepareToPlay()
        audioSoundTrack.play()
        
    }
    
    func playSoundGoal() {
        let fileSoundGoalPath = NSBundle.mainBundle().pathForResource("football-crowd-goal", ofType: "wav")
        let url = NSURL(fileURLWithPath: fileSoundGoalPath!)
        
        audioGoal = try! AVAudioPlayer(contentsOfURL: url)
        audioGoal.prepareToPlay()
        audioGoal.play()
    }
    
    func playRefereeWhistleSound()
    {
        let refereeWistleSound = NSBundle.mainBundle().pathForResource("referee-whistle", ofType: "wav")
        let url = NSURL(fileURLWithPath: refereeWistleSound!)
        
        audioWistle = try! AVAudioPlayer(contentsOfURL: url)
        audioWistle.prepareToPlay()
        audioWistle.play()
    }
    
//    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
//        audioSoundTrack.play()
//    }

}

