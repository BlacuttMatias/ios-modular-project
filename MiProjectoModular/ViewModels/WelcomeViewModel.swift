//
//  WelcomeViewModel.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 14/12/2021.
//

import Foundation

class WelcomeViewModel{
    func getAppInfoAlertTitle() -> String{
        return "App Info"
    }
    func getAppInfoAlertMessage() -> String{
        let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        let messageAlert = "Copyright @ 2021\n\(appName)\nVersion \(shortVersion) (\(version))"
        return messageAlert
    }
}
