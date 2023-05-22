//
//  View.swift
//  AppSalary
//
//  Created by Nariman Vildanov on 14.04.2023.
//

import Foundation
import SwiftUI
import Combine

struct KeyboardMove {
    let willShow: Bool
    let animation: Animation?
    let height: CGFloat?
}

extension View {
    var keyboardPublisher: AnyPublisher<KeyboardMove, Never> {
        Publishers
            .Merge(
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillShowNotification)
                    .map { notification in
                        return keyBoardParams(from: notification, willShow: true)
                    }
                ,
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillHideNotification)
                    .map { notification in
                        return keyBoardParams(from: notification, willShow: false)
                    }
            )
            .debounce(for: 0.01, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func keyBoardParams(from notification: Notification, willShow: Bool) -> KeyboardMove {
        guard
            let info = notification.userInfo,
            let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curveValue = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
            let uiKitCurve = UIView.AnimationCurve(rawValue: curveValue),
            let height = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        else {
            return KeyboardMove(willShow: willShow, animation: nil, height: nil)
        }
        
        let timing = UICubicTimingParameters(animationCurve: uiKitCurve)
        if let springParams = timing.springTimingParameters,
           let mass = springParams.mass, let stiffness = springParams.stiffness, let damping = springParams.damping {
            return KeyboardMove(willShow: willShow,
                                animation: Animation.interpolatingSpring(mass: mass, stiffness: stiffness, damping: damping),
                                height: height)
        } else {
            return KeyboardMove(willShow: willShow,
                                animation: Animation.easeOut(duration: duration),
                                height: height)
        }
    }
}

private extension UISpringTimingParameters {
    var mass: Double? {
        value(forKey: "mass") as? Double
    }
    var stiffness: Double? {
        value(forKey: "stiffness") as? Double
    }
    var damping: Double? {
        value(forKey: "damping") as? Double
    }
}

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
}
