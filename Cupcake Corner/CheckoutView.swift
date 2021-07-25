// CheckoutView.swift

import SwiftUI



struct CheckoutView: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   @ObservedObject var order: Order
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      GeometryReader { geometryProxy in
         ScrollView(.vertical) {
            VStack {
               Image("cupcakes")
                  .resizable()
                  .scaledToFit()
                  .frame(width: geometryProxy.size.width)
               Text("Your order: $ \(order.totalPrice, specifier: "%.2f")")
               Button(action: {
                  print("The button is tapped.")
               }) {
                  Text("Place Order")
               }
               .padding()
            }
         }
      }.navigationBarTitle("Checkout",
                           displayMode: .inline)
   }
}





// MARK: - PREVIEWS -

struct CheckoutView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      CheckoutView(order: Order())
   }
}
