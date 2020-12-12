//
//  RestaurantTPRegViewController.swift
//  Check✓
//
//  Created by George Rosescu on 16.11.2020.
//

import Foundation
import UIKit
import Firebase

class RestaurantTPRegViewController: UIViewController{
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var noItemsImageView: UIImageView!
    @IBOutlet weak var noItemsLabel: UILabel!
    @IBOutlet weak var itemsTableView: UITableView!
    
    var restaurantToRegister = Restaurant()
    var products = [Product]() {
        didSet {
            itemsTableView.isHidden = products.isEmpty
            if !products.isEmpty {
                itemsTableView.reloadData()
            }
        }
    }
    
    let firestore = Firestore.firestore()
    let storage = Storage.storage().reference().child(RestaurantConstants.FStore.picturesCollectionName)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.currentPage = 2
        
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsTableView.register(UINib(nibName: "MenuItemCell", bundle: nil), forCellReuseIdentifier: "MenuItemCell")
        
        finishButton.configureRoundButtonWithShadow()
    }
    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func addItemAction(_ sender: UIButton) {
        var productName = ""
        var productPrice = ""
        var productIngredients = ""
        
        let productAlert = UIAlertController(title: "Menu product", message: "Add a new product to menu", preferredStyle: .alert)
        
        productAlert.addTextField { (nameTextField) in
            nameTextField.placeholder = "Product name"
            nameTextField.autocapitalizationType = .sentences
        }
        
        productAlert.addTextField { (priceTextField) in
            priceTextField.placeholder = "Product price and currency"
        }
        
        productAlert.addTextField { (ingredientsTextField) in
            ingredientsTextField.placeholder = "Product ingredients"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addProductAction = UIAlertAction(title: "Add", style: .default) { (_) in
            productName = productAlert.textFields![0].text!
            productPrice = productAlert.textFields![1].text!
            productIngredients = productAlert.textFields![2].text!
            
            if productName.count > 1 && productPrice.count > 1 && productIngredients.count > 1 {
                self.addProduct(name: productName, price: productPrice, ingredients: productIngredients)
            } else {
                SwiftMessagesAlert.displaySmallErrorWithBody("Please enter valid product data.")
            }
        }
        productAlert.addAction(cancelAction)
        productAlert.addAction(addProductAction)
        
        self.present(productAlert, animated: true, completion: nil)
    }
    
    private func addProduct(name: String, price: String, ingredients: String) {
        var image = UIImage()
        
        if name.lowercased().contains("pizza") {
            image = #imageLiteral(resourceName: "pizza")
        } else if name.lowercased().contains("sushi") {
            image = #imageLiteral(resourceName: "sushi")
        } else if name.lowercased().contains("double") {
            image = #imageLiteral(resourceName: "doubleBurger")
        } else if name.lowercased().contains("tacos") {
            image = #imageLiteral(resourceName: "tacos")
        } else if name.lowercased().contains("bolognese") {
            image = #imageLiteral(resourceName: "pastaBolognese")
        } else if name.lowercased().contains("home") || name.lowercased().contains("burger") {
            image = #imageLiteral(resourceName: "homeBurger")
        } else if name.lowercased().contains("carbonara") {
            image = #imageLiteral(resourceName: "pastaCarbonara")
        } else {
            image = #imageLiteral(resourceName: "savureaza")
        }
        
        let newMenuProduct = Product(price: price, name: name, ingrediends: ingredients, image: image)
        products.insert(newMenuProduct, at: 0)
    }
    
    @IBAction func finishAction(_ sender: UIButton) {
        spinner.startAnimating()
        
        guard let profilePictureData = restaurantToRegister.profilePicture?.jpegData(compressionQuality: 1) else { return }
        let imageName = UUID().uuidString
        
        let imageStorage = storage.child(imageName)
        
        imageStorage.putData(profilePictureData, metadata: nil) { (metadata, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            } else {
                let data: [String: Any] = [
                    RestaurantConstants.FStore.uid: self.restaurantToRegister.uid!,
                    RestaurantConstants.FStore.name: self.restaurantToRegister.name!,
                    RestaurantConstants.FStore.address: self.restaurantToRegister.address!,
                    RestaurantConstants.FStore.description: self.restaurantToRegister.description!,
                    RestaurantConstants.FStore.email: self.restaurantToRegister.email!,
                    RestaurantConstants.FStore.openingHour: self.restaurantToRegister.openingHour!,
                    RestaurantConstants.FStore.closingHour: self.restaurantToRegister.closingHour!,
                    RestaurantConstants.FStore.phoneNumber: self.restaurantToRegister.phoneNumber!,
                    RestaurantConstants.FStore.pictureURL: imageName
                ]
                
                
                self.firestore.collection(RestaurantConstants.FStore.collectionName).addDocument(data: data) { (error) in
                    self.spinner.stopAnimating()
                    if let error = error {
                        SwiftMessagesAlert.displaySmallErrorWithBody(error.localizedDescription)
                    } else {
                        Session.isRegisterRestaurant = true
                        SwiftMessagesAlert.displaySmallSuccessWithBody("Registration successful🤩")
                        guard let checkerMainMenu = AppStoryboards.RestaurantMainApp.instance?.instantiateViewController(identifier: "RestaurantTabBarViewController") as? RestaurantTabBarViewController else { return }
                        checkerMainMenu.tabBar.isUserInteractionEnabled = false
                        self.navigationController?.pushViewController(checkerMainMenu, animated: true)
                    }
                }
            }
        }
    }
}
