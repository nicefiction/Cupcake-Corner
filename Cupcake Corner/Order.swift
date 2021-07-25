// Order.swift

import SwiftUI


class Order: ObservableObject {
   
   // MARK: - PROPERTY WRAPPERS
   
   @Published var cakeTypeIndex: Int = 0
   @Published var numberOfCakes: Int = 3
   @Published var hasSpecialRequestEnabled: Bool = false {
      didSet {
         if hasSpecialRequestEnabled == false {
            hasFrosting = false
            hasSprinkles = false
         }
      }
   }
   @Published var hasFrosting: Bool = false
   @Published var hasSprinkles: Bool = false
   
   
   // MARK: - PROPERTIES
   
   static let cakeTypes: [String] = [
      "Vanilla", "Chocolate", "Cinnamon", "Carrot"
   ]
   
   
   // MARK: - COMPUTED PROPERTIES
   
//   var hasDisabledOptions: Bool {
//
//      hasSpecialRequestEnabled ? false : true
//   }
}


/*
 class Order: ObservableObject {
     static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

     @Published var type = 0
     @Published var quantity = 3

     @Published var specialRequestEnabled = false
     @Published var extraFrosting = false
     @Published var addSprinkles = false
 }
 */
