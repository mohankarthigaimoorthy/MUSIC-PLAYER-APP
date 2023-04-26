//
//  songViewController.swift
//  musicPlayer
//
//  Created by Mohan K on 06/01/23.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer
import MarqueeLabel

class songViewController: UIViewController, AVAudioPlayerDelegate {
 
    @IBOutlet weak var songInfo: UICollectionView!
    
    @IBOutlet weak var songDetails: MarqueeLabel!
    
    @IBOutlet weak var partnerBrand: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var startTime: UILabel!
    
    @IBOutlet weak var stopTime: UILabel!
    
    @IBOutlet weak var playbackSlider: UISlider!
    
    @IBOutlet weak var shuffleBtn: UIButton!
    
    @IBOutlet weak var likeBtn: UIButton!
    
    
    var rest = [restAPI]()
   
    var songs = [Model]()
    var isMix = false
    var randomInt = 0
    var nowPlayingInfo = [String : Any]()
    var audioPlayer = AVAudioPlayer()
    var activeSong = 0
    var songList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        songInfo.delegate = self
        songInfo.dataSource = self
        
        songInfo.register(songCollectionViewCell.nib(), forCellWithReuseIdentifier: songCollectionViewCell.identifier)
    
        songs.append(Model(text: "fiction", image: "img1", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities" , brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "4.9"))
        songs.append(Model(text: "non fiction", image: "img2", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "5.9"))
        songs.append(Model(text: "pulpi fiction", image: "img3", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "6.9"))
        songs.append(Model(text: "tactic fiction", image: "img4", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "7.9"))
        songs.append(Model(text: "static fiction", image: "img5", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "8.9"))
        songs.append(Model(text: "dramatic fiction", image: "img6", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "4.9"))
        songs.append(Model(text: "in fiction", image: "img7", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "5.9"))
        songs.append(Model(text: "out fiction", image: "img8", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "6.9"))
        songs.append(Model(text: "up fiction", image: "img9", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "7.9"))
        songs.append(Model(text: "right fiction", image: "img10", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "8.9"))
        songs.append(Model(text: "left fiction", image: "img11", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "4.9"))
        songs.append(Model(text: "down fiction", image: "img12", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "5.9"))
        songs.append(Model(text: "random fiction", image: "img13", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "6.9"))
        
        songDetails.text = songs[0].new
        partnerBrand.text = songs[0].brand
//        songDetails.text =
//        partnerBrand.text =
        
        getSongs()
        prapareSong()
        pauseSong()
        
        
        songDetails.speed = .duration(10)
        songDetails.animationCurve = .easeInOut
        songDetails.fadeLength = 10.0
        songDetails.leadingBuffer = 30.0
        
        
        let url = URL(string:  "https://api.opendota.com/api/heroStats")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    self.rest = try JSONDecoder().decode([restAPI].self, from: data!)
                }catch {
                    print("Parse Error")
                }
                
                DispatchQueue.main.async {
                    self.songInfo.reloadData()
                    print(self.rest.count)
                }
            }
                
        }.resume()
    
        likeBtn.addTarget(self, action: #selector (likeBtnTapped), for: .touchUpInside)
        
    }
  
    @objc func  likeBtnTapped(sender:UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            UIView.animate(withDuration: 0.3, delay: 0, options:  .curveEaseOut) {
                sender.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
            } completion: { finished in
                UIView.animate(withDuration: 0.3) {
                    sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
            }
        }else {
            UIView.animate(withDuration: 0.3, delay: 0, options:  .curveEaseOut) {
                sender.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
            } completion: { finished in
                UIView.animate(withDuration: 0.3) {
                    sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
            }
        }
    }


    @IBAction func playBtn(_ sender: UIButton) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            playButton.setImage(UIImage(systemName: "play"), for: .normal)
            updateTime()
            self.showToast(message: "Song is paused", font: .systemFont(ofSize: 12.0))
        }else{
            audioPlayer.play()
            playButton.setImage(UIImage(systemName: "pause"), for: .normal)
            updateTime()
            self.showToast(message: "Song is on your Ears", font: .systemFont(ofSize: 12.0))
        }
       
    }
    
    
    @IBAction func backward(_ sender: UIButton) {
        if isMix {
            if randomInt < songList.count - 1 {
                randomInt -= 1
                if randomInt < 0  {
                    randomInt = 0
                    return
                }
                activeSong = randomInt
                playThisSong(activeSong: songList[randomInt])
                startTime.text = ""
                stopTime.text = ""
                updateTime()
                audioPlayer.play()
                playButton.setImage(UIImage(named: "pause"), for: .normal)
            }
            else{
                randomInt = 0
                activeSong = 0
                playThisSong(activeSong: songList[activeSong])
                startTime.text = ""
                stopTime.text = ""
                updateTime()
                audioPlayer.play()
                playButton.setImage(UIImage(systemName: "pause"), for: .normal)
            }
        }else{
            
            if activeSong < songList.count - 1 {
                activeSong -= 1
                if activeSong < 0 {
                    activeSong = 0
                    return
                }
                playThisSong(activeSong: songList[activeSong])
                startTime.text = ""
                stopTime.text = ""
                updateTime()
                audioPlayer.play()
                playButton.setImage(UIImage(systemName: "pause"), for: .normal)
            }
            else {
                activeSong = 0
                playThisSong(activeSong: songList[activeSong])
                startTime.text = ""
                stopTime.text = ""
                updateTime()
                audioPlayer.play()
                playButton.setImage(UIImage(systemName: "pause"), for: .normal)
            }
        }
        self.showToast(message: "Song is play backward", font: .systemFont(ofSize: 12.0))
    }
  
    
    @IBAction func forwardBtn(_ sender: UIButton) {
        if isMix {
            if randomInt < songList.count - 1 {
                randomInt += 1
                activeSong = randomInt
                playThisSong(activeSong: songList[activeSong])
                startTime.text = ""
                stopTime.text = ""
                updateTime()
                audioPlayer.play()
                playButton.setImage(UIImage(systemName: "pause"), for: .normal)
                
            }else{
                randomInt = 0
                activeSong = 0
                playThisSong(activeSong: songList[activeSong])
                startTime.text = ""
                stopTime.text = ""
                updateTime()
                audioPlayer.play()
                playButton.setImage(UIImage(systemName: "pause"), for: .normal)
            }
            
        }else{
            if activeSong < songList.count - 1 {
                activeSong += 1
                if activeSong > songList.count {
                    activeSong = 0
                    return
                }
                playThisSong(activeSong: songList[activeSong])
                startTime.text = ""
                stopTime.text = ""
                updateTime()
                audioPlayer.play()
                playButton.setImage(UIImage(systemName: "pause"), for: .normal)
            }else{
                activeSong = 0
                playThisSong(activeSong: songList[activeSong])
                startTime.text = ""
                stopTime.text = ""
                updateTime()
                audioPlayer.play()
                playButton.setImage(UIImage(systemName: "pause"), for: .normal)
            }
        }
        self.showToast(message: "Song is play forward", font: .systemFont(ofSize: 12.0))
    }
    
    
    @IBAction func shufflebutton(_ sender: UIButton) {
        
        
        
        if isMix{
            isMix = false
            shuffleBtn.setImage(UIImage(systemName: "mix"), for: .normal)
        }
        else{
            isMix = true
            shuffleBtn.setImage(UIImage(systemName: "mix-selected"), for: .normal)
        }
        
        self.showToast(message: "shuffled", font: .systemFont(ofSize: 12.0))
        
    }
    
  
    @IBAction func musicSlide(_ sender: UISlider) {
        
        if audioPlayer.isPlaying {
            audioPlayer.stop()
            audioPlayer.currentTime =  TimeInterval(playbackSlider.value)
            audioPlayer.play()
        }else{
            audioPlayer.currentTime = TimeInterval(playbackSlider.value)
        }
        
    }
    
   
    func updateTime() {
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        playbackSlider.maximumValue = Float(audioPlayer.duration)
        stopTime.text = stringFormatterTimeInterval(interval: audioPlayer.duration) as String
    }
    func stringFormatterTimeInterval(interval : TimeInterval) ->NSString {
        let ti = NSInteger(interval)
        let second = ti % 60
        let minutes = ( ti / 60) % 60
        return NSString(format: "%0.2d:%0.2d", minutes,second)
    }
    @objc func update (_timer : Timer ) {
        playbackSlider.value = Float(audioPlayer.currentTime)
        startTime.text =  stringFormatterTimeInterval(interval: TimeInterval(playbackSlider.value)) as String
        
        
    }
    func prapareSong(){
        do{
            let audioPath = Bundle.main.path(forResource: songList[activeSong], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.prepareToPlay()
            audioPlayer.delegate = self
            
            
            
        }
        catch{
            print(error.localizedDescription)
        }
    }
    func getSongs()  {
        
        let folderUrl = URL(fileURLWithPath: Bundle.main.resourcePath!)
        do{
            let path = try FileManager.default.contentsOfDirectory(at: folderUrl,includingPropertiesForKeys: nil,options: .skipsHiddenFiles)
            for song_ in path{
                var songName = song_.absoluteString
                if songName.contains(".mp3")
                {
                    let finfString = songName.components(separatedBy: "/")
                    songName = finfString[finfString.count - 1]
                    songName = songName.replacingOccurrences(of: "%20", with: " ")
                    songName = songName.replacingOccurrences(of: ".mp3", with: "")
                    songList.append(songName)
                    print(songName)
                }
            }
        }
        
        catch
        {
            print("err")
        }
    }
    
    func playThisSong(activeSong : String)  {
        
        do {
            let audioPath = Bundle.main.path(forResource: activeSong, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.prepareToPlay()
            randomInt = Int.random(in: 0...songList.count)
            
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func pauseSong(){
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        }
    }
    
    
}
    
extension songViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rest.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = songInfo.dequeueReusableCell(withReuseIdentifier: "songCollectionViewCell", for: indexPath) as! songCollectionViewCell
        
        
            let defaultLink = "https://api.opendota.com"
            let completeLink = defaultLink + rest[indexPath.row].img
            cell.musicPlayInfo.downloadedFrom(link: completeLink)
//        cell.musicPlayInfo.image = UIImage(named: songs[indexPath.row].image)
        cell.ratingLabel.text = "\(rest[indexPath.row].id)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 300, height: 400)
    }
    
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }

}
