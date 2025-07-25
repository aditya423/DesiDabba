//
//  Constants.swift
//  DesiDabba
//
//  Created by Aditya on 22/07/25.
//

enum FileNames: String {
    case homeTableViewCell = "HomeTableViewCell"
    case menuViewController = "MenuViewController"
    case menuTableViewCell = "MenuTableViewCell"
    case cartViewController = "CartViewController"
    case checkoutViewController = "CheckoutViewController"
}

enum ImageConstants: String {
    case appLogo = "desiDabbaLogo"
    case starFill = "star_check"
    case starEmpty = "star.fill"
    case restaurantTemp = "restaurantImage"
    case placeholder = "placeholder"
    case systemName = "person.fill"
    case systemEmail = "envelope.fill"
    case systemAddress = "house.fill"
    case systemCheck = "checkmark.circle.fill"
}

enum AlertMessages: String {
    case success = "Success"
    case oops = "Oops!"
    case error = "Error"
    case sorry = "Sorry!"
    case note = "Note"
    case somethingWentWrong = "Something went wrong."
    case successMsg = "Dish added to cart successfully."
    case oopsMsg = "Dish is already present in the cart."
    case sorryMsg = "No dishes in the cart for checkout."
    case noteMsg = "Please fill all the textfields."
}

enum StringConstants: String {
    case orderPlaced = "Order Placed Successfully!"
    case thankYou = "Thank you for your order. We'll start preparing it right away."
}

enum ButtonTitles: String {
    case done = "Done"
}
