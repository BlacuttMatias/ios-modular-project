//
//  AudioPlayer.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 12/11/2021.
//

import Foundation
import AudioPlayer

class AudioPlayerManager{
    
    private var sound: AudioPlayer?
    private var audioState: AudioState
    
    init(file: String, fileExtension: String){
        self.audioState = PausedState()
        let possibleUrl = Bundle.main.url(forResource: file, withExtension: fileExtension)
        guard let url = possibleUrl else{
            return
        }
        do{
            self.sound = try AudioPlayer(contentsOf: url)
        }
        catch{
            print("Error al cargar el sonido: \(error.localizedDescription)")
        }
    }
    
    func play(){
        self.sound?.play()
        self.audioState = PlayingState(audioPlayer: self)
    }
    
    func pause(){
        self.sound?.stop()
    }
    
    func resume(){
        self.sound?.play()
    }
    
    func getVolume() -> Float{
        guard let sound = self.sound else{
            return 0
        }
        return sound.volume
    }
    
    func setVolume(volume: Float){
        self.sound?.volume = volume
    }
    
    func changePlayingState(){
        self.audioState.changePlayingState()
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

}
