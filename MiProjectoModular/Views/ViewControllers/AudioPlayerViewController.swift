//
//  AudioPlayerViewController.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 05/11/2021.
//

import UIKit

class AudioPlayerViewController: UIViewController, UiMenuCreator {

    private var menuButton: UIButton = UIButton(type: .system)
    private var audioPlayerLabel: UILabel = UILabel()
    private var playButton: UIButton = UIButton(type: .system)
    private var previousButton: UIButton = UIButton(type: .system)
    private var nextButton : UIButton = UIButton(type: .system)
    private var playSlider: UISlider = UISlider()
    private var volumeImage: UIImageView = UIImageView()
    private var volumeSlider: UISlider = UISlider ()
    private var stopButton: UIButton = UIButton(type: .system)
    private var playingImage: UIImageView = UIImageView()
    private var audioPlayerViewModel: AudioPlayerViewModel? = AudioPlayerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //obtiene el alto y ancho de la pantalla que se esta usando
        //let w = UIScreen.main.currentMode?.size.width
        //let h = UIScreen.main.currentMode?.size.height
        self.audioPlayerViewModel?.audioDelegate = self
        self.audioPlayerViewModel?.setMenuDelegate(menuDelegate: self)
        self.audioPlayerViewModel?.setSound(file: self.getNameSoundFileWithoutExtension(), fileExtension: "mp3")
        
        self.view.backgroundColor = .white
        
        self.audioPlayerViewModel?.play()

        self.setMenuButton()
        self.setAudioPlayerLabel()
        self.setPlayButton()
        self.setPreviousButton()
        self.setNextButton()
        self.setPlaySlider()
        self.setVolumeLabel()
        self.setVolumeSlider()
        self.setPlayingImage()
        self.refreshUiNewTrack()
    }
    
    func setTracks(currentTrack: Track, tracks: [Track]){
        self.audioPlayerViewModel?.setTracks(currentTrack: currentTrack, tracks: tracks)
    }
    
    private func track() -> Track?{
        return self.audioPlayerViewModel?.getCurrentTrack()
    }
    
    private func getNameSoundFileWithoutExtension() -> String{
        return Resource.audio
    }
    
    private func setAudioPlayerLabel(){
        audioPlayerLabel.text = self.track()?.title ?? "AudioPlayer"
        audioPlayerLabel.setFontSize(30)
        
        //audioPlayerLabel.autoresizingMask = .flexibleWidth
        //audioPlayerLabel.translatesAutoresizingMaskIntoConstraints=false
        //audioPlayerLabel.frame=CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50)
        audioPlayerLabel.textAlignment = .center
        self.view.addSubview(audioPlayerLabel)
        
        let constraintSetter = ConstraintsSetter(uiView: audioPlayerLabel)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.view.topAnchor, distance: 60)
        constraintSetter.setCenterXContraint(referenceAnchorView: self.view.centerXAnchor)

    }
    
    private func setPlayButton(){
        let image = UIImage(named: self.audioPlayerViewModel?.getActionImageName() ?? Resource.welcomeImage)
        playButton.setImage(image, for: .normal)
        playButton.setBlueIcon()
        
        self.playButton.addTarget(self, action: #selector(playButtonTouch), for: .touchUpInside)
        
        self.view.addSubview(playButton)
        
        let constraintSetter = ConstraintsSetter(uiView: playButton)
        constraintSetter.setTopEqualContraint(referenceAnchorView: audioPlayerLabel.bottomAnchor, distance: 40)
        constraintSetter.setCenterXContraint(referenceAnchorView: self.view.centerXAnchor)
        constraintSetter.setHeightConstraint(height: 60)
        constraintSetter.setWidthConstraint(width: 60)
        
    }
    
    @objc private func playButtonTouch(){
        self.changeStatePlaying()
    }
    
    private func changeStatePlaying(){
        self.audioPlayerViewModel?.changePlayingState()
    }
    
    private func getDurationTrack() -> Float{
        //let duration = self.track?.duration ?? 3000
        //return Float(duration)
        return 146.42
    }
    
    
    private func setPreviousButton(){
        let image = UIImage(named: Resource.skipPrevious)
        previousButton.setImage(image, for: .normal)
        previousButton.setBlueIcon()
        
        self.previousButton.addTarget(self, action: #selector(previousButtonTouch), for: .touchUpInside)
        
        self.view.addSubview(previousButton)
        
        let constraintSetter = ConstraintsSetter(uiView: previousButton)
        constraintSetter.setTopEqualContraint(referenceAnchorView: audioPlayerLabel.bottomAnchor, distance: 40)
        constraintSetter.setRightEqualContraint(referenceAnchorView: playButton.leadingAnchor, distance: -20)
        constraintSetter.setHeightConstraint(height: 60)
        constraintSetter.setWidthConstraint(width: 60)
    }
    
    @objc private func previousButtonTouch(){
        self.self.audioPlayerViewModel?.previousTrack()
        self.refreshUiNewTrack()
        self.audioPlayerViewModel?.setSound(file: Resource.audio, fileExtension: "mp3")
    }
    
    private func setNextButton(){
        let image = UIImage(named: Resource.skipNext)
        nextButton.setImage(image, for: .normal)
        nextButton.setBlueIcon()
        
        self.nextButton.addTarget(self, action: #selector(nextButtonTouch), for: .touchUpInside)
        
        self.view.addSubview(nextButton)
        
        let constraintSetter = ConstraintsSetter(uiView: nextButton)
        constraintSetter.setTopEqualContraint(referenceAnchorView: audioPlayerLabel.bottomAnchor, distance: 40)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: playButton.trailingAnchor, distance: 20)
        constraintSetter.setHeightConstraint(height: 60)
        constraintSetter.setWidthConstraint(width: 60)
    }
    
    @objc private func nextButtonTouch(){
        self.self.audioPlayerViewModel?.nextTrack()
        self.refreshUiNewTrack()
        self.audioPlayerViewModel?.setSound(file: self.getNameSoundFileWithoutExtension(), fileExtension: "mp3")
    }
    
    func refreshUiNewTrack(){
        self.previousButton.isHidden = false
        self.nextButton.isHidden = false
        guard let tracksPlayer = self.self.audioPlayerViewModel else{
            return
        }
        if(tracksPlayer.areInTheFirstTrack()){
            self.previousButton.isHidden = true
        }
           else if(tracksPlayer.areInTheLastTrack()){
            self.nextButton.isHidden = true
        }
        self.audioPlayerLabel.text = self.track()?.title
        self.playSlider.value = 0.0
    }
    
    private func setPlaySlider(){
        self.playSlider.maximumValue = self.getDurationTrack()
        
        self.view.addSubview(playSlider)
        
        playSlider.addTarget(self, action: #selector(currentTimeSongChanged), for: .touchUpInside)

        
        let constraintSetter = ConstraintsSetter(uiView: playSlider)
        constraintSetter.setTopEqualContraint(referenceAnchorView: playButton.bottomAnchor, distance: 40)
        constraintSetter.setRightEqualContraint(referenceAnchorView: self.view.trailingAnchor, distance: -20)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.view.leadingAnchor, distance: 20)
        constraintSetter.setHeightConstraint(height: 50)
    
    }
    
    @objc private func currentTimeSongChanged(){
        self.audioPlayerViewModel?.setCurrentTime(currentTime: playSlider.value)
    }
    
    private func setVolumeLabel(){
        volumeImage.image = UIImage(named: audioPlayerViewModel?.getNameImageVolume() ?? Resource.volumeDowm)?.withRenderingMode(.alwaysTemplate)
        volumeImage.image?.setBlueIcon()
        
        self.view.addSubview(volumeImage)
                
        let constraintSetter = ConstraintsSetter(uiView: volumeImage)
        constraintSetter.setTopEqualContraint(referenceAnchorView: playSlider.bottomAnchor, distance: 35)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.view.leadingAnchor, distance: 20)
        
    }
    
    private func setVolumeSlider(){
        volumeSlider.value = self.audioPlayerViewModel?.getVolume() ?? 1
        self.view.addSubview(volumeSlider)
        
        volumeSlider.addTarget(self, action: #selector(volumeChanged), for: .valueChanged)
        
        let constraintSetter = ConstraintsSetter(uiView: volumeSlider)
        constraintSetter.setTopEqualContraint(referenceAnchorView: playSlider.bottomAnchor, distance: 35)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: volumeImage.trailingAnchor, distance: 10)
        constraintSetter.setWidthConstraint(width: self.view.frame.width/2)
        constraintSetter.setHeightConstraint(height: 50)
        
    }
    
    @objc func volumeChanged(){
        let volume = volumeSlider.value
        self.audioPlayerViewModel?.setVolume(volume: volume)
        self.volumeImage.image = UIImage(named: audioPlayerViewModel?.getNameImageVolume() ?? Resource.volumeDowm)?.withRenderingMode(.alwaysTemplate)
        self.volumeImage.image?.setBlueIcon()
    }
    
    private func setPlayingImage(){
        self.playingImage.image = self.audioPlayerViewModel?.getImagePlaying()?.getImage()
        
        self.view.addSubview(self.playingImage)
        
        let constraintSetter = ConstraintsSetter(uiView: playingImage)
        constraintSetter.setTopEqualContraint(referenceAnchorView: volumeSlider.bottomAnchor, distance: 40)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.view.leadingAnchor, distance: 0, priority: 1000)
        constraintSetter.setRightEqualContraint(referenceAnchorView: self.view.trailingAnchor, distance: 0, priority: 1000)
        constraintSetter.setHeightConstraint(height: 150)
        
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.audioPlayerViewModel?.pause()
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        self.changeStatePlaying()
    }
    
    private func setMenuButton(){
        
        let image = UIImage(named: Resource.menuIcon)
        menuButton.setImage(image, for: .normal)
        menuButton.tintColor = .lightGray
        menuButton.menu = self.getUiMenu()
        menuButton.showsMenuAsPrimaryAction = true
        
        self.view.addSubview(menuButton)
        
        let constraintSetter = ConstraintsSetter(uiView: menuButton)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.view.topAnchor, distance: 15)
        constraintSetter.setRightEqualContraint(referenceAnchorView: self.view.trailingAnchor, distance: -15)

    }
    
    private func refreshUiMenu(){
        menuButton.menu = self.getUiMenu()
    }
    
    private func getUiMenu() -> UIMenu{
        return self.createUiMenu(actions: self.audioPlayerViewModel?.getActionsMenu(), title: "")
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

extension AudioPlayerViewController: AudioDelegate {
    
    func onChangePlayingState() {
        let image = UIImage(named: self.audioPlayerViewModel?.getActionImageName() ?? Resource.welcomeImage)
        self.playButton.setImage(image, for: .normal)
        self.playingImage.image = self.audioPlayerViewModel?.getImagePlaying()?.getImage()
    }
    
    func onChangeCurrentTimeSong(updatedCurrentTime: Float) {
        if(!playSlider.isTouchInside){
            self.playSlider.value = updatedCurrentTime
        }
    }
    
    func onSongFinished() {
        guard let tracksPlayer = self.self.audioPlayerViewModel else{
            return
        }
        if(tracksPlayer.areNotInTheLastTrack()){
            self.nextButtonTouch()
        }
        else{
            self.audioPlayerViewModel?.changePlayingState()
        }
    }
}

extension AudioPlayerViewController: MenuAudioPlayerDelegate {
    func deleteLybrary(action: UIAction) {
        return
    }
    
    func downloadSong(action: UIAction) {
        self.audioPlayerViewModel?.doDownloadAction()
        let titleAlert = self.audioPlayerViewModel?.getTitleDownloadAction()
        let messageAlert = self.audioPlayerViewModel?.getMessageDownloadAction()
        self.showAlertAndRefreshUiMenu(titleAlert: titleAlert, messageAlert: messageAlert)
    }
    
    func addToPlaylist(action: UIAction) {
        return
    }
    
    func shareSong(action: UIAction) {
        return
    }
    
    func love(action: UIAction) {
        self.audioPlayerViewModel?.doLoveAction()
        let titleAlert = self.audioPlayerViewModel?.getTitleLoveAction()
        let messageAlert = self.audioPlayerViewModel?.getMessageLoveAction()
        self.showAlertAndRefreshUiMenu(titleAlert: titleAlert, messageAlert: messageAlert)
    }
    
    private func showAlertAndRefreshUiMenu(titleAlert: String?, messageAlert: String?){
        self.showSimpleAlert(title: titleAlert, message: messageAlert)
        self.refreshUiMenu()
    }
}
