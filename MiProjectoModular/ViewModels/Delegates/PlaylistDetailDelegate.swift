//
//  PlaylistDetailDelegate.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 02/12/2021.
//

import Foundation

protocol PlaylistDetailDelegate: AnyObject{
    func reloadPicker()
    func songAdded()
    func songRemoved()
}
