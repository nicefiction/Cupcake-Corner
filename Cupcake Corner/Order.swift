// Order.swift

import SwiftUI


class Order: ObservableObject,
             Codable {
   
   // MARK: - NESTED TYPES
   
   enum CodingKeys: CodingKey {
      case cakeTypeIndex, numberOfCakes, hasFrosting, hasSprinkles, name, streetAddress, city, zip
   }
   
   
   
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
   
   
   
   // MARK: - INITIALIZER METHODS
   
   required init(from decoder: Decoder)
   throws {
      
      // let jsonDecoder: JSONDecoder = JSONDecoder()
      
      let decodingContainer = try decoder.container(keyedBy: CodingKeys.self)
      
      self.cakeTypeIndex = try decodingContainer.decode(Int.self   , forKey: CodingKeys.cakeTypeIndex)
      self.numberOfCakes = try decodingContainer.decode(Int.self   , forKey: CodingKeys.numberOfCakes)
      self.hasFrosting   = try decodingContainer.decode(Bool.self  , forKey: CodingKeys.hasFrosting)
      self.hasSprinkles  = try decodingContainer.decode(Bool.self  , forKey: CodingKeys.hasSprinkles)
      self.name          = try decodingContainer.decode(String.self, forKey: CodingKeys.name)
      self.streetAddress = try decodingContainer.decode(String.self, forKey: CodingKeys.streetAddress)
      self.city          = try decodingContainer.decode(String.self, forKey: CodingKeys.city)
      self.zip           = try decodingContainer.decode(String.self, forKey: CodingKeys.zip)
   }
   
   
   init() {}
   
   
   
   // MARK: - PROPERTIES
   
   static let cakeTypes: [String] = [
      
      "Vanilla", "Chocolate", "Cinnamon", "Carrot"
   ]
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var hasValidAddress: Bool {

      return name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty ? false : true
   }
   
   
   var totalPrice: Double {
      
      // Base cost:
      var cupcakeCost = 2 * Double(numberOfCakes)
      // + Flavor:
      cupcakeCost += Double(cakeTypeIndex) / 2
      // + Sprinkles:
      cupcakeCost += hasSprinkles ? Double(numberOfCakes) : 0
      // + Frosting:
      cupcakeCost += hasSprinkles ? Double(numberOfCakes) / 2 : 0
      
      return cupcakeCost
   }
   
   
   
   // MARK: METHODS
   
   func encode(to encoder: Encoder)
   throws {
      
      var encodingContainer = encoder.container(keyedBy: CodingKeys.self)
      
      try encodingContainer.encode(cakeTypeIndex, forKey: CodingKeys.cakeTypeIndex)
      try encodingContainer.encode(numberOfCakes, forKey: CodingKeys.numberOfCakes)
      try encodingContainer.encode(hasFrosting, forKey: CodingKeys.hasFrosting)
      try encodingContainer.encode(hasSprinkles, forKey: CodingKeys.hasSprinkles)
      try encodingContainer.encode(name, forKey: CodingKeys.name)
      try encodingContainer.encode(streetAddress, forKey: CodingKeys.streetAddress)
      try encodingContainer.encode(city, forKey: CodingKeys.city)
      try encodingContainer.encode(zip, forKey: CodingKeys.zip)
   }
}
