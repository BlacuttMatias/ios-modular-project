//
//  ConstraintsSetter.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 11/11/2021.
//

import Foundation

class ConstraintsSetter{
    private var uiView: UIView
    
    init(uiView: UIView){
        self.uiView = uiView
        self.uiView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setPriorityAndActivate(constraint: NSLayoutConstraint, priority: Float){
        constraint.priority = UILayoutPriority(priority)
        constraint.isActive = true
    }
    
    func setTopEqualContraint(referenceAnchorView: NSLayoutAnchor<NSLayoutYAxisAnchor>, distance: CGFloat, priority: Float = 500){
        let constraint = uiView.topAnchor.constraint(equalTo: referenceAnchorView, constant: distance)
        self.setPriorityAndActivate(constraint: constraint, priority: priority)
    }
    
    func setTopGreatherThanConstraint(referenceAnchorView: NSLayoutAnchor<NSLayoutYAxisAnchor>, distance: CGFloat, priority: Float = 1000){
        let constraint = uiView.topAnchor.constraint(greaterThanOrEqualTo: referenceAnchorView, constant: distance)
        self.setPriorityAndActivate(constraint: constraint, priority: priority)
    }
    
    func setLeftEqualContraint(referenceAnchorView: NSLayoutAnchor<NSLayoutXAxisAnchor>, distance: CGFloat, priority: Float = 500){
        let constraint = uiView.leadingAnchor.constraint(equalTo: referenceAnchorView, constant: distance)
        self.setPriorityAndActivate(constraint: constraint, priority: priority)
    }
    
    func setLeftGreatherThanConstraint(referenceAnchorView: NSLayoutAnchor<NSLayoutXAxisAnchor>, distance: CGFloat, priority: Float = 1000){
        let constraint = uiView.leadingAnchor.constraint(greaterThanOrEqualTo: referenceAnchorView, constant: distance)
        self.setPriorityAndActivate(constraint: constraint, priority: priority)
    }
    
    func setRightEqualContraint(referenceAnchorView: NSLayoutAnchor<NSLayoutXAxisAnchor>, distance: CGFloat, priority: Float = 500){
        let constraint = uiView.trailingAnchor.constraint(equalTo: referenceAnchorView, constant: distance)
        self.setPriorityAndActivate(constraint: constraint, priority: priority)
    }
    
    func setRightGreatherThanConstraint(referenceAnchorView: NSLayoutAnchor<NSLayoutXAxisAnchor>, distance: CGFloat, priority: Float = 1000){
        let constraint = uiView.trailingAnchor.constraint(greaterThanOrEqualTo: referenceAnchorView, constant: distance)
        self.setPriorityAndActivate(constraint: constraint, priority: priority)
    }
    
    func setCenterXContraint(referenceAnchorView: NSLayoutAnchor<NSLayoutXAxisAnchor>){
        let constraint = uiView.centerXAnchor.constraint(equalTo: referenceAnchorView)
        constraint.isActive = true
    }
    
    func setHeightConstraint(height: CGFloat){
        let constraint = uiView.heightAnchor.constraint(equalToConstant: height)
        constraint.isActive = true
    }
    
    func setWidthConstraint(width: CGFloat){
        let constraint = uiView.widthAnchor.constraint(equalToConstant: width)
        constraint.isActive = true
    }
    
}
