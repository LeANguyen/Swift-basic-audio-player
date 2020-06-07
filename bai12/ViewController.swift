//
//  ViewController.swift
//  bai12
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 Le An Nguyen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var musicTableView: UITableView!
    var musicArray: [Music] = []
    let notifier = NotificationCenter.default
    var musicDetailVC = MusicDetailViewController()
    
    static var audioDelegate: AudioDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        musicDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MusicDetailViewController") as! MusicDetailViewController
        musicTableView.delegate = self
        musicTableView.dataSource = self
        
        musicArray.append(Music(name: "Song number 1", logoURL: "https://news.bitcoin.com/wp-content/uploads/2018/01/va.jpg", audioURL: "http://23.237.126.42/ost/the-sims-2-soundtrack/jtjwhzrg/CAS%20-%2002%207997049D-FF549C7F-FF713B26.mp3", artist: "Artist number 1"))
        musicArray.append(Music(name: "Song number 2", logoURL: "https://pixel.nymag.com/imgs/fashion/daily/2018/07/23/23-beach-umbrella.w1200.h630.jpg", audioURL: "http://23.237.126.42/ost/the-sims-2-soundtrack/uoekwcsx/Build%20-%2003%20E26BA5D7-FF606C7A-FF155C17.mp3", artist: "Artist number 2"))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell", for: indexPath) as! MusicTableViewCell
        let url = URL(string: musicArray[indexPath.row].logoURL)!
        
        do {
            let data = try Data(contentsOf: url)
            cell.logoImageView.image = UIImage(data: data)
        } catch {
            print("Error")
        }
        cell.songNameLabel.text = musicArray[indexPath.row].name
        cell.artistLabel.text = musicArray[indexPath.row].artist
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: musicArray[indexPath.row].logoURL)!
        do {
            let data = try Data(contentsOf: url)
            musicDetailVC.logoImage = UIImage(data: data)
        } catch {
            print("Error")
        }
        
        let audioURL = URL(string: musicArray[indexPath.row].audioURL)!
        do {
            print("Downloading Audio")
            let data = try Data(contentsOf: audioURL)
            print("Audio Downloaded")
            notifier.post(name: NSNotification.Name("stop"), object: nil)
            ViewController.audioDelegate?.stopAudio()
            musicDetailVC.audioPlayer = try AVAudioPlayer(data: data)
            navigationController?.pushViewController(musicDetailVC, animated: true)
        } catch {
            print("Downloading Error")
            print(error)
        }
    }
}

struct Music {
    var name: String
    var logoURL: String
    var audioURL: String
    var artist: String
}

