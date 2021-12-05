//
//  TrackerDelegate.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 01/12/2021.
//

import Foundation

protocol TrackerDelegate: AnyObject, ButtonOnCellDelegate{
    func dismissLoadingAlert()
    func reloadDataTable()
}
