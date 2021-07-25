// AddressView.swift

import SwiftUI



struct AddressView: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   @ObservedObject var order: Order
   
   
   // MARK: - PROPERTIES
   
   // let order: Order
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      Form {
         Section(header: Text("your order")) {
            Text("\(order.numberOfCakes) \(Order.cakeTypes[order.cakeTypeIndex]) cakes.")
         }
         Section(header: Text("your address")) {
            TextField("Your name...", text: $order.name)
            TextField("Street...", text: $order.streetAddress)
            TextField("City...", text: $order.city)
            TextField("ZIP...", text: $order.zip)
         }
         Section {
            NavigationLink("Checkout", destination: CheckoutView(order: order))
         }
         .disabled(order.hasValidAddress == false)
      }
      .navigationBarTitle(Text("Delivery Details"),
                          displayMode: .inline)
   }
}





// MARK: - PREVIEWS -

struct AddressView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      AddressView(order: Order())
   }
}
