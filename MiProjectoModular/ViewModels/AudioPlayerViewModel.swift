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
    var audioDelegate: AudioDelegate
    
    init(file: String, fileExtension: String, audioDelegate: AudioDelegate){
        self.audioState = PausedState()
        self.audioDelegate = audioDelegate
        self.setSound(file: file, fileExtension: fileExtension)
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
        self.audioDelegate.onChangePlayingState()
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
        self.audioDelegate.onChangeCurrentTimeSong(updatedCurrentTime: self.getCurrentTime())
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
                    self.audioDelegate.onSongFinished()
                }
            }
            self.audioState.newSoundSetted()
            self.setVolume(volume: currentVolume)
        }
        catch{
            print("Error al cargar el sonido: \(error.localizedDescription)")
        }
    }

}
