//
//  MusicDetailViewController.swift
//  bai12
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 Le An Nguyen. All rights reserved.
//

import UIKit
import AVFoundation

protocol AudioDelegate {
    func stopAudio()
}

class MusicDetailViewController: UIViewController, AudioDelegate {
    var logoImage: UIImage?
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var logoImageView: UIImageView!
    var audioPlayer: AVAudioPlayer?
    let observer = NotificationCenter.default
    
    override func viewWillLayoutSubviews() {
        print(logoImageView.frame.height)
        logoImageView.image = logoImage
        logoImageView.layer.cornerRadius = logoImageView.frame.height / 2
        logoImageView.clipsToBounds = true
    }
    
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        observer.addObserver(self, selector: #selector(self.stopAudio), name: NSNotification.Name("stop"), object: nil)
        ViewController.audioDelegate = self
        durationSlider.value = 0
        durationSlider.maximumValue = Float((audioPlayer?.duration)!)
        
        
        
        Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(imageSpinning), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    
    @IBAction func durationChanged(_ sender: Any) {
        audioPlayer?.currentTime = Double(durationSlider.value)
    }
    
    @objc func imageSpinning() {
        logoImageView.transform = logoImageView.transform.rotated(by: .pi / 180)
        durationSlider.value = Float((audioPlayer?.currentTime)!)
        
        if audioPlayer?.currentTime == 0 {
            audioPlayer?.play()
        }
    }
    
    @objc func stopAudio() {
        audioPlayer?.stop()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
