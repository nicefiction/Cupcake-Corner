// AddressView.swift

import SwiftUI



struct AddressView: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   @ObservedObject var order: Order
   
   
   // MARK: - PROPERTIES
   
   // let order: Order
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      Text("\(order.numberOfCakes) \(Order.cakeTypes[order.cakeTypeIndex]) cakes.")
   }
}





// MARK: - PREVIEWS -

struct AddressView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      AddressView(order: Order())
   }
}
