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
   @Published var name: String = ""
   @Published var streetAddress: String = ""
   @Published var city: String = ""
   @Published var zip: String = ""
   
   
   
   // MARK: - PROPERTIES
   
   static let cakeTypes: [String] = [
      
      "Vanilla", "Chocolate", "Cinnamon", "Carrot"
   ]
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var hasValidAddress: Bool {

      return name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty ? false : true
   }
}
