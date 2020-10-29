//
//  MessagesHandler.swift
//  Check✓
//
//  Created by George Rosescu on 29/10/2020.
//

import Foundation
import SwiftMessages

struct MesssagesHandler {
    
    static func displaySmallErrorWithBody(_ body: String) {
        let errorView = MessageView.viewFromNib(layout: .statusLine)
        
        errorView.configureTheme(.error)
        errorView.configureContent(title: "Error", body: body)
        SwiftMessages.show(view: errorView)
    }
}
