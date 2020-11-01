//
//  OnboardingViewModel.swift
//  Check✓
//
//  Created by George Rosescu on 20/10/2020.
//

import Foundation
import UIKit

struct OnboardingViewModel {
    let onboardingScreens: [OnboardingScreens] = [.First, .Second, .Third, .Fourth]
    
    var currentPage = 0
    
    func getCurrentPageContent() -> OnboardingScreen {
        return onboardingScreens[currentPage].getScreen()
    }
    
    mutating func nextPage() {
        if currentPage + 1 < onboardingScreens.count {
            currentPage += 1
        }
    }
}

enum OnboardingScreens {
    
    case First
    case Second
    case Third
    case Fourth
    
    func getScreen() -> OnboardingScreen {
        switch self {
        case .First:
            return OnboardingScreen(image: OnboardingContent.firstImage, title: OnboardingContent.firstTitle, description: OnboardingContent.firstDescription)
        case .Second:
            return OnboardingScreen(image: OnboardingContent.secondImage, title: OnboardingContent.secondTitle, description: OnboardingContent.secondDescription)
        case .Third:
            return OnboardingScreen(image: OnboardingContent.thirdImage, title: OnboardingContent.thirdTitle, description: OnboardingContent.thirdDescription)
        case .Fourth:
            return OnboardingScreen(image: OnboardingContent.fourthImage, title: OnboardingContent.fourthTitle, description: OnboardingContent.fourthDescription)
        }
    }
}

private struct OnboardingContent {
    
    //first screen
    static let firstImage = #imageLiteral(resourceName: "descopera")
    static let firstTitle = "Desopera"
    static let firstDescription = "Descopera restaurantele si cafenelele din jurul tau. Poti selecta dintr-o gama larga de locatii cele care se potrivesc stilului si asteptarilor tale"
    
    //second screen
    static let secondImage = #imageLiteral(resourceName: "alege")
    static let secondTitle = "Alege"
    static let secondDescription = "In cazul in care dorsti ca preparatele tale preferate sa te astepte gata de a fi servite, poti opta pentru a trimite comanda ta chiar de acasa, pentru ca ele sa fie gata pe cand ajungi"
    
    
    //third screen
    static let thirdImage = #imageLiteral(resourceName: "rezerva")
    static let thirdTitle = "Rezerva"
    static let thirdDescription = "Dupa ce ai gasit localul perfect si ai ales produsele dorite, in cazul in care doresti ca ele sa fie gata pentru cand ajungi, poti rezerva simplu si rapid o masa pentru tine si toate persoanele care te vor insoti"
    
    
    //fourth screen
    static let fourthImage = #imageLiteral(resourceName: "savureaza")
    static let fourthTitle = "Savureaza!"
    static let fourthDescription = "Nu ramane decat sa savurezi o intalnire de exceptie alaturi de persoanele dragi si preparatele tale favorite"
}
