// ContentView.swift

import SwiftUI


struct ContentView: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   @ObservedObject var order: Order = Order()
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      NavigationView {
         Form {
            Section {
               Picker("Flavour",
                      selection: $order.cakeTypeIndex) {
                  ForEach(0..<Order.cakeTypes.count) { (index: Int) in
                     Text(Order.cakeTypes[index])
                  }
                      }
               Stepper("\(order.numberOfCakes) Cupcakes",
                       value: $order.numberOfCakes,
                       in: 3...9)
            }
            Section {
               Toggle("Special Requests",
                      isOn: $order.hasSpecialRequestEnabled.animation())
               if order.hasSpecialRequestEnabled {
                  Toggle("Frosting",
                         isOn: $order.hasFrosting)
                  Toggle("Sprinkles",
                         isOn: $order.hasSprinkles)
               }
            }
            Section {
               NavigationLink("Delivery Details",
                              destination: AddressView(order: order))
            }
         }
         .navigationBarTitle(Text("Cupcake Corner"))
      }
   }
}





// MARK: - PREVIEWS -

struct ContentView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      ContentView()
   }
}
