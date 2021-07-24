// User.swift

import Foundation


final class User: ObservableObject,
            Codable {
   
   // MARK: - PROPERTY WRAPPERS
   
   @Published var name: String
   
   
   
   // MARK: - NESTED TYPES
   
   enum CodingKeys: CodingKey {
      
      case name
   }
   
   
   
   // MARK: - INITIALIZER METHODS
   
   init(from decoder: Decoder)
   throws {
      
      // let jsonDecoder = JSONDecoder()
      
      let userDecodingContainer = try decoder.container(keyedBy: CodingKeys.self)
      
      self.name = try userDecodingContainer.decode(String.self,
                                                   forKey: CodingKeys.name)
   }
   
   
   
   // MARK: - METHODS
   
   func encode(to encoder: Encoder)
   throws {
      
      var userEncodingContainer = encoder.container(keyedBy: CodingKeys.self)
      
      try userEncodingContainer.encode(name,
                                       forKey: CodingKeys.name)
   }
}
