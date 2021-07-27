// CheckoutView.swift
// SOURCE: https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-orders-over-the-internet

import SwiftUI



struct CheckoutView: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   let order: Order
   // @ObservedObject var order: Order
   @State private var isShowingConfirmationAlert: Bool = false
   @State private var confirmationMessage: String = ""
   @State private var isShowingFailureAlert: Bool = false
   @State private var failureMessage: String = "There is no internet connection."
   
   
   
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
                  placeOrder()
               }) {
                  Text("Place Order")
               }
               .padding()
               .alert(isPresented: isShowingConfirmationAlert ? $isShowingConfirmationAlert : $isShowingFailureAlert) {
                  Alert(title: Text("\(isShowingConfirmationAlert ? "Thank you!" : "Error")"),
                        message: Text("\(isShowingConfirmationAlert ? confirmationMessage : failureMessage)"),
                        dismissButton: .default(Text("OK")))
               }
            }
         }
      }
      .navigationBarTitle("Checkout",
                          displayMode: .inline)
   }
   
   
   
   // MARK: METHODS
   
   /** OVERVIEW :
    `Codable` —> Converts Swift objects to and from JSON .
    `URLRequest`—> Configures how data should be sent .
    `URLSession`—> Sends and receives data .
    */
   func placeOrder() {
      
      /// 1. Convert our current Order object into some JSON data that can be sent :
      
      let jsonEncoder: JSONEncoder = JSONEncoder()
      guard let _encodedData = try? jsonEncoder.encode(order)
      else {
         print("Failed to encode order.")
         return
      }
      
      
      /// 2. Prepare a URLRequest to send our encoded data as JSON :
      
      let cupcakesURL = URL(string: "https://reqres.in/api/cupcakes")!
      var urlRequest = URLRequest(url: cupcakesURL)
      urlRequest.setValue("application/json",
                          forHTTPHeaderField: "Content-Type")
      urlRequest.httpMethod = "POST"
      urlRequest.httpBody = _encodedData
      
      
      /// 3. Run that request and process the response :
      
      URLSession.shared.dataTask(with: urlRequest) { (data: Data?,
                                                      urlResponse: URLResponse?,
                                                      error: Error?) in
         /// If something went wrong – perhaps because there was no internet connection –
         /// we’ll just print a message and return  :
         guard let _data = data
         else {
            print("No data in response: \(error?.localizedDescription ?? "Unknown Error")")
            isShowingFailureAlert.toggle()
            return
         }
         /// If we make it past that , it means we got some sort of data back from the server .
         /// Because we are using the ReqRes.in ,
         /// we will actually get back to the same order we sent ,
         /// which means we can use JSONDecoder to convert that back from JSON to an object .
         /// And now we can finish off our networking code:
         /// we’ll decode the data that came back , ...
         if let _decodedOrder = try? JSONDecoder().decode(Order.self,
                                                          from: _data) {
            /// ... use it to set our confirmation message property,
            /// then set showingConfirmation to true so the alert appears :
            self.confirmationMessage = "You have ordered \(_decodedOrder.numberOfCakes) \(Order.cakeTypes[_decodedOrder.cakeTypeIndex].lowercased()) cakes."
            isShowingConfirmationAlert.toggle()
         } else {
            /// If the decoding fails – if the server sent back something that wasn’t an order for some reason –
            /// we’ll just print an error message :
            print("There has been an invalid response from the server.")
         }
      }.resume()
   }
}





// MARK: - PREVIEWS -

struct CheckoutView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      CheckoutView(order: Order())
   }
}
