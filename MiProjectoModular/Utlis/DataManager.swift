//
//  DataManager.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 18/11/2021.
//

import Foundation

struct DataManager{
    static func songsByGenre(tracks: [Track]) -> [Track]{
        return tracks.filter({ $0.genre != nil })
    }
}
