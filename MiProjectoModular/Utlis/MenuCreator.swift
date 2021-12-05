//
//  ActionsMenuCreator.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 05/12/2021.
//

import Foundation

struct MenuCreator{
    
    func createUiAction(withAction action: ActionMenuButton) -> UIAction{
        return UIAction(title: action.title, image: UIImage(named: action.imageName), attributes: action.attributes ?? [], handler: action.actionHandler)
    }

    func createMenu(withActions actions: [ActionMenuButton], title: String) -> UIMenu{
        let uiActions = actions.map({self.createUiAction(withAction: $0)})
        return UIMenu(title: title, children: uiActions)
    }
}
