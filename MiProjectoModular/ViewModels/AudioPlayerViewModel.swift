//
//  AudioPlayer.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 12/11/2021.
//

import Foundation
import AudioPlayer

class AudioPlayerViewModel{
    
    private var sound: AudioPlayer? = nil
    private var audioState: AudioState
    private var timer: Timer?
    var audioDelegate: AudioDelegate?
    private var tracksPlayer: TracksPlayer?
    private var menuDelegate: MenuAudioPlayerDelegate?
    private var wasDownloaded: Bool = Bool()
    
    init(file: String, fileExtension: String, audioDelegate: AudioDelegate){
        self.audioState = PausedState()
        self.audioDelegate = audioDelegate
        self.setSound(file: file, fileExtension: fileExtension)
    }
    
    init(){
        self.audioState = PausedState()
    }
    
    deinit{
        timer?.invalidate()
    }
    
    private func setTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateCurrentTimeSong), userInfo: nil, repeats: true)
    }
    
    func play(){
        self.sound?.play()
        self.audioState = PlayingState(audioPlayer: self)
        self.setTimer()
    }
    
    func pause(){
        self.sound?.stop()
        timer?.invalidate()
    }
    
    func resume(){
        self.sound?.play()
        self.setTimer()
    }
    
    func getVolume() -> Float{
        guard let sound = self.sound else{
            return 1
        }
        return sound.volume
    }
    
    func setVolume(volume: Float){
        self.sound?.volume = volume
    }
    
    func changePlayingState(){
        self.audioState.changePlayingState()
        self.audioDelegate?.onChangePlayingState()
    }
    
    func getActionImageName() -> String{
        self.audioState.getEnabledActionImageName()
    }
    
    func getImagePlaying() -> Image?{
        self.audioState.getImagePlaying()
    }
    
    func changeTo(audioState: AudioState){
        self.audioState = audioState
    }
    
    func setCurrentTime(currentTime: Float){
        self.sound?.currentTime = TimeInterval(currentTime)
    }
    
    func getCurrentTime() -> Float{
        return Float(self.sound?.currentTime ?? 0)
    }
    
    @objc private func updateCurrentTimeSong(){
        self.audioDelegate?.onChangeCurrentTimeSong(updatedCurrentTime: self.getCurrentTime())
    }
    
    func getNameImageVolume() -> String{
        guard let volume = sound?.volume else{
            return Resource.volumeDowm
        }
        if volume == 0 {
            return Resource.volumeMute
        }
        else if volume < 0.5{
            return Resource.volumeDowm
        }
        else{
            return Resource.volumeUp
        }
    }
    
    func setSound(file: String, fileExtension: String){
        let possibleUrl = Bundle.main.url(forResource: file, withExtension: fileExtension)
        guard let url = possibleUrl else{
            return
        }
        do{
            let currentVolume = self.getVolume()
            self.sound = try AudioPlayer(contentsOf: url)
            self.sound?.completionHandler = {finished in
                if(finished){
                    self.audioDelegate?.onSongFinished()
                }
            }
            self.audioState.newSoundSetted()
            self.setVolume(volume: currentVolume)
        }
        catch{
            print("Error al cargar el sonido: \(error.localizedDescription)")
        }
    }
    
    func setTracks(currentTrack: Track, tracks: [Track]){
        self.tracksPlayer = TracksPlayer(currentTrack: currentTrack, tracks: tracks)
    }
    
    func nextTrack(){
        self.tracksPlayer?.nextTrack()
    }
    
    func previousTrack(){
        self.tracksPlayer?.previousTrack()
    }
    
    func areInTheFirstTrack() -> Bool{
        return self.tracksPlayer?.areInTheFirstTrack() ?? true
    }
    
    func areInTheLastTrack() -> Bool{
        return self.tracksPlayer?.areInTheLastTrack() ?? true
    }
    
    func areNotInTheLastTrack() -> Bool{
        return self.tracksPlayer?.areNotInTheLastTrack() ?? false
    }
    
    func getCurrentTrack() -> TrackWithLove?{
        return self.tracksPlayer?.getCurrentTrack()
    }
    
    func setMenuDelegate(menuDelegate: MenuAudioPlayerDelegate){
        self.menuDelegate = menuDelegate
    }
    
    func getActionsMenu() -> [ActionMenuButton]{
        var actions = [
            ActionMenuButton(title: TitleActionMenuAudioPlayer.removeFromLybrary.rawValue, imageName: Resource.deleteIcon, actionHandler: { self.menuDelegate?.deleteLybrary(action: $0) }, attributes: .destructive),
            ActionMenuButton(title: TitleActionMenuAudioPlayer.addToAPlaylist.rawValue, imageName: Resource.addPlaylistIcon, actionHandler: { self.menuDelegate?.addToPlaylist(action: $0) }),
            ActionMenuButton(title: TitleActionMenuAudioPlayer.shareSong.rawValue, imageName: Resource.shareIcon, actionHandler: { self.menuDelegate?.shareSong(action: $0) }),
        ]
        if(!self.wasDownloaded){
            let downloadAction = ActionMenuButton(title: TitleActionMenuAudioPlayer.download.rawValue, imageName: Resource.downloadIcon, actionHandler: { self.menuDelegate?.downloadSong(action: $0) })
            actions.insert(downloadAction, at: 1)
        }
        
        var loveAction: ActionMenuButton
        if(self.getLoveCurrentTrack()){
            loveAction = ActionMenuButton(title: TitleActionMenuAudioPlayer.unloved.rawValue, imageName: Resource.unloveIcon, actionHandler: { self.menuDelegate?.love(action: $0) })
        }
        else{
            loveAction = ActionMenuButton(title: TitleActionMenuAudioPlayer.love.rawValue, imageName: Resource.loveIcon, actionHandler: { self.menuDelegate?.love(action: $0) })
        }
        actions.append(loveAction)
        return actions
    }
    
    func getLoveCurrentTrack() -> Bool{
        return self.getCurrentTrack()!.love
    }
    
    func doLoveAction(){
        self.getCurrentTrack()?.changeLove()
    }
    
    func getTitleLoveAction() -> String{
        if(self.getLoveCurrentTrack()){
            return "Loved"
        }
        else{
            return "Unloved"
        }
    }
    
    func getMessageLoveAction() -> String{
        if(self.getLoveCurrentTrack()){
            return "We will recommend more like this in Listen Now"
        }
        else{
            return "We will NOT recommend more like this in Listen Now"
        }
    }
    
    func doDownloadAction(){
        self.wasDownloaded = true
    }
    
    func getTitleDownloadAction() -> String{
        return "Downloading song..."
    }
    
    func getMessageDownloadAction() -> String{
        let titleSong = tracksPlayer?.currentTrack.title ?? "Unknown"
        let artistSong = tracksPlayer?.currentTrack.artist ?? "Unknown"
        let albumSong = tracksPlayer?.currentTrack.album ?? "Unknown"
        return "Title: \(titleSong)\n Artist: \(artistSong)\n Album: \(albumSong)"
    }

}
