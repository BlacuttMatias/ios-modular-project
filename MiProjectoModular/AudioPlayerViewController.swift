//
//  AudioPlayerViewController.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 05/11/2021.
//

import UIKit

class AudioPlayerViewController: UIViewController {

    private var audioPlayerLabel: UILabel = UILabel()
    private var playButton: UIButton = UIButton(type: .system)
    private var playSlider: UISlider = UISlider()
    private var volumeLabel: UILabel = UILabel()
    private var volumeSlider: UISlider = UISlider ()
    private var stopButton: UIButton = UIButton(type: .system)
    private var playingImage: UIImageView = UIImageView()
    
    private var isPlaying: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //obtiene el alto y ancho de la pantalla que se esta usando
        //let w = UIScreen.main.currentMode?.size.width
        //let h = UIScreen.main.currentMode?.size.height
        
        self.view.backgroundColor = .white

        self.setAudioPlayerLabel()
        self.setPlayButton()
        self.setStopButton()
        self.setPlaySlider()
        self.setVolumeLabel()
        self.setVolumeSlider()
        self.setPlayingImage()
        
    }
    
    private func setAudioPlayerLabel(){
        audioPlayerLabel.text = "AudioPlayer"
        audioPlayerLabel.font = UIFont.systemFont(ofSize: 30)
        
        //audioPlayerLabel.autoresizingMask = .flexibleWidth
        audioPlayerLabel.translatesAutoresizingMaskIntoConstraints=false
        //audioPlayerLabel.frame=CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50)
        audioPlayerLabel.textAlignment = .center
        self.view.addSubview(audioPlayerLabel)
        
        NSLayoutConstraint.activate([
            audioPlayerLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            audioPlayerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func setPlayButton(){
        playButton.setTitle("Play", for: .normal)
        playButton.translatesAutoresizingMaskIntoConstraints=false
        playButton.setTitleColor(UIColor.blue, for: .normal)
        self.view.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: audioPlayerLabel.bottomAnchor, constant: 20),
            playButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            playButton.widthAnchor.constraint(equalToConstant: 100),
            playButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setStopButton(){
        stopButton.setTitle("Stop", for: .normal)
        stopButton.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(stopButton)
        
        NSLayoutConstraint.activate([
            stopButton.topAnchor.constraint(equalTo: audioPlayerLabel.bottomAnchor, constant: 20),
            stopButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            stopButton.widthAnchor.constraint(equalToConstant: 100),
            stopButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setPlaySlider(){
        playSlider.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(playSlider)
        
        NSLayoutConstraint.activate([
            playSlider.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 20),
            playSlider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            playSlider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            playSlider.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setVolumeLabel(){
        volumeLabel.text = "Volume"
        volumeLabel.font = UIFont.systemFont(ofSize: 18)
        
        volumeLabel.translatesAutoresizingMaskIntoConstraints=false
        volumeLabel.textAlignment = .left
        self.view.addSubview(volumeLabel)
        
        NSLayoutConstraint.activate([
            volumeLabel.topAnchor.constraint(equalTo: playSlider.bottomAnchor, constant: 25),
            volumeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        ])
    }
    
    private func setVolumeSlider(){
        volumeSlider.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(volumeSlider)
        
        NSLayoutConstraint.activate([
            volumeSlider.topAnchor.constraint(equalTo: volumeLabel.bottomAnchor, constant: 20),
            volumeSlider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            volumeSlider.widthAnchor.constraint(equalToConstant: self.view.frame.width/2),
            volumeSlider.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setPlayingImage(){
        let possibleUrlImage = Bundle.main.url(forResource: "stegosaurus-studio", withExtension: "gif")
        guard let urlImage = possibleUrlImage else {
            return
        }
        let animatedImage = UIImage.animatedImage(withAnimatedGIFURL: urlImage)
        self.playingImage.image = animatedImage
        playingImage.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(self.playingImage)
        NSLayoutConstraint.activate([
            playingImage.topAnchor.constraint(equalTo: volumeSlider.bottomAnchor, constant: 40),
            playingImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            playingImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            playingImage.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        self.isPlaying.toggle()
        if(self.isPlaying){
            print("Playing")
        }
        else{
            print("Not playing")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
