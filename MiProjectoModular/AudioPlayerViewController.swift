//
//  AudioPlayerViewController.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 05/11/2021.
//

import UIKit

class AudioPlayerViewController: UIViewController, AudioDelegate {

    private var audioPlayerLabel: UILabel = UILabel()
    private var playButton: UIButton = UIButton(type: .system)
    private var playSlider: UISlider = UISlider()
    private var volumeLabel: UILabel = UILabel()
    private var volumeSlider: UISlider = UISlider ()
    private var stopButton: UIButton = UIButton(type: .system)
    private var playingImage: UIImageView = UIImageView()
    private weak var audioPlayer: AudioPlayerManager?
    private var track: Track?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //obtiene el alto y ancho de la pantalla que se esta usando
        //let w = UIScreen.main.currentMode?.size.width
        //let h = UIScreen.main.currentMode?.size.height
        self.audioPlayer = AudioPlayerManager(file: Resource.audio, fileExtension: "mp3")
        self.audioPlayer!.audioDelegate = self
        
        self.view.backgroundColor = .white
        
        self.audioPlayer?.play()

        self.setAudioPlayerLabel()
        self.setPlayButton()
        self.setPlaySlider()
        self.setVolumeLabel()
        self.setVolumeSlider()
        self.setPlayingImage()
    }
    
    private func setAudioPlayerLabel(){
        audioPlayerLabel.text = self.track?.title ?? "AudioPlayer"
        audioPlayerLabel.font = UIFont.systemFont(ofSize: 30)
        
        //audioPlayerLabel.autoresizingMask = .flexibleWidth
        //audioPlayerLabel.translatesAutoresizingMaskIntoConstraints=false
        //audioPlayerLabel.frame=CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50)
        audioPlayerLabel.textAlignment = .center
        self.view.addSubview(audioPlayerLabel)
        
        let constraintSetter = ConstraintsSetter(uiView: audioPlayerLabel)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.view.topAnchor, distance: 50)
        constraintSetter.setCenterXContraint(referenceAnchorView: self.view.centerXAnchor)

    }
    
    private func setPlayButton(){
        let image = UIImage(named: self.audioPlayer?.getActionImageName() ?? Resource.welcomeImage)
        playButton.setImage(image, for: .normal)
        playButton.setTitleColor(UIColor.blue, for: .normal)
        
        self.playButton.addTarget(self, action: #selector(playButtonTouch), for: .touchUpInside)
        
        self.view.addSubview(playButton)
        
        let constraintSetter = ConstraintsSetter(uiView: playButton)
        constraintSetter.setTopEqualContraint(referenceAnchorView: audioPlayerLabel.bottomAnchor, distance: 20)
        constraintSetter.setCenterXContraint(referenceAnchorView: self.view.centerXAnchor)
        constraintSetter.setHeightConstraint(height: 50)
        constraintSetter.setWidthConstraint(width: 50)
        
    }
    
    @objc private func playButtonTouch(){
        self.changeStatePlaying()
    }
    
    private func changeStatePlaying(){
        self.audioPlayer?.changePlayingState()
    }
    
    private func getDurationTrack() -> Float{
        let duration = self.track?.duration ?? "3000"
        return Float(duration) ?? 3000
    }
    
    private func setPlaySlider(){
        self.playSlider.maximumValue = self.getDurationTrack()
        
        self.view.addSubview(playSlider)
        
        playSlider.addTarget(self, action: #selector(currentTimeSongChanged), for: .touchUpInside)

        
        let constraintSetter = ConstraintsSetter(uiView: playSlider)
        constraintSetter.setTopEqualContraint(referenceAnchorView: playButton.bottomAnchor, distance: 20)
        constraintSetter.setRightEqualContraint(referenceAnchorView: self.view.trailingAnchor, distance: -20)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.view.leadingAnchor, distance: 20)
        constraintSetter.setHeightConstraint(height: 50)
    
    }
    
    @objc private func currentTimeSongChanged(){
        print(playSlider.value)
        self.audioPlayer?.setCurrentTime(currentTime: playSlider.value)
    }
    
    private func setVolumeLabel(){
        volumeLabel.text = "Volume"
        volumeLabel.font = UIFont.systemFont(ofSize: 18)
        
        self.view.addSubview(volumeLabel)
                
        let constraintSetter = ConstraintsSetter(uiView: volumeLabel)
        constraintSetter.setTopEqualContraint(referenceAnchorView: playSlider.bottomAnchor, distance: 25)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.view.leadingAnchor, distance: 20)
        
    }
    
    private func setVolumeSlider(){
        volumeSlider.value = self.audioPlayer?.getVolume() ?? 1
        self.view.addSubview(volumeSlider)
        
        volumeSlider.addTarget(self, action: #selector(volumeChanged), for: .valueChanged)
        
        let constraintSetter = ConstraintsSetter(uiView: volumeSlider)
        constraintSetter.setTopEqualContraint(referenceAnchorView: volumeLabel.bottomAnchor, distance: 20)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.view.leadingAnchor, distance: 20)
        constraintSetter.setWidthConstraint(width: self.view.frame.width/2)
        constraintSetter.setHeightConstraint(height: 50)
        
    }
    
    @objc func volumeChanged(){
        let volume = volumeSlider.value
        self.audioPlayer?.setVolume(volume: volume)
    }
    
    private func setPlayingImage(){
        self.playingImage.image = self.audioPlayer?.getImagePlaying()?.getImage()
        
        self.view.addSubview(self.playingImage)
        
        let constraintSetter = ConstraintsSetter(uiView: playingImage)
        constraintSetter.setTopEqualContraint(referenceAnchorView: volumeSlider.bottomAnchor, distance: 40)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.view.leadingAnchor, distance: 0, priority: 1000)
        constraintSetter.setRightEqualContraint(referenceAnchorView: self.view.trailingAnchor, distance: 0, priority: 1000)
        constraintSetter.setHeightConstraint(height: 150)
        
    }
    
    func OnChangePlayingState() {
        let image = UIImage(named: self.audioPlayer?.getActionImageName() ?? Resource.welcomeImage)
        self.playButton.setImage(image, for: .normal)
        self.playingImage.image = self.audioPlayer?.getImagePlaying()?.getImage()
    }
    
    func OnChangeCurrentTimeSong(updatedCurrentTime: Float) {
        if(!playSlider.isTouchInside){
            self.playSlider.value = updatedCurrentTime
        }
    }
    
    
    func setTrack(track: Track){
        self.track = track
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer?.pause()
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        self.changeStatePlaying()
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
