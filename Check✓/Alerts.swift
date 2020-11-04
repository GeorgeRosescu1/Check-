//
//  Alerts.swift
//  Check✓
//
//  Created by George Rosescu on 04/11/2020.
//

import Foundation
import UIKit

struct Alerts {
    
    static func presentAlertWithOneMainAction(withTitle title: String, message: String, mainAction: @escaping () -> Void,
                                              actionTitle: String, fromVC viewController: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertMainAction = UIAlertAction(title: actionTitle, style: .destructive) { _ in
            mainAction()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(alertMainAction)
        alert.addAction(cancelAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
