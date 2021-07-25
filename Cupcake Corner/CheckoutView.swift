// CheckoutView.swift

import SwiftUI



struct CheckoutView: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   @ObservedObject var order: Order
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
   }
}





// MARK: - PREVIEWS -

struct CheckoutView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      CheckoutView(order: Order())
   }
}
