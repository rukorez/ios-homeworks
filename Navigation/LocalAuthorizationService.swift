//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Филипп Степанов on 15.12.2022.
//

import Foundation
import UIKit
import LocalAuthentication

final class LocalAuthorizationService {
    
    let context = LAContext()
    var canUseBiometrics: Bool?
    var policy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
    var biometryType: LABiometryType {
        return context.biometryType
    }
    var error: NSError?
    
    init() {
        canUseBiometrics = context.canEvaluatePolicy(policy, error: &error)
    }
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool, Error?) -> Void) {
        
//        var error: NSError?
//        canUseBiometrics = context.canEvaluatePolicy(policy, error: &error)
        
        if let error = error {
            authorizationFinished(false, error)
            return
        }
        
        context.localizedCancelTitle = NSLocalizedString("LocalAuthorizationServiceLocalizedCancelTitle", comment: "")
        context.evaluatePolicy(policy,
                               localizedReason: NSLocalizedString("LocalAuthorizationServiceLocalizedReason", comment: ""))
        { success, error in
            DispatchQueue.main.async {
                if success {
                    authorizationFinished(success, nil)
                }
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
}
