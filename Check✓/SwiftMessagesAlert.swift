//
//  Messages.swift
//  Check✓
//
//  Created by George Rosescu on 30/10/2020.
//

import Foundation
import SwiftMessages

struct SwiftMessagesAlert {
    
    static func displaySmallErrorWithBody(_ body: String) {
        let errorView = MessageView.viewFromNib(layout: .statusLine)
        
        errorView.configureTheme(.error)
        errorView.configureContent(title: "Error", body: body)
        SwiftMessages.show(view: errorView)
    }
    
    static func displaySmallSuccessWithBody(_ body: String) {
        let errorView = MessageView.viewFromNib(layout: .statusLine)
        
        errorView.configureTheme(.success)
        errorView.configureContent(title: "Success", body: body)
        SwiftMessages.show(view: errorView)
    }
}
