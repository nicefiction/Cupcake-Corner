// CheckoutView.swift
// SOURCE: https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-orders-over-the-internet

import SwiftUI



struct CheckoutView: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   @ObservedObject var order: Order
   @State private var isShowingAlert: Bool = false
   @State private var alertMessage: String = ""
   
   
   
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
            }
         }
      }.navigationBarTitle("Checkout",
                           displayMode: .inline)
      .alert(isPresented: $isShowingAlert) {
         Alert(title: Text("Thank you!"),
               message: Text("\(alertMessage)"),
               dismissButton: .default(Text("OK")))
      }
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
            return
         }
         /// If we make it past that , it means we got some sort of data back from the server .
         /// Because we are using the ReqRes.in ,
         /// we will actually get back to the same order we sent ,
         /// which means we can use JSONDecoder to convert that back from JSON to an object .
         ///   And now we can finish off our networking code:
         /// we’ll decode the data that came back,
         /// use it to set our confirmation message property,
         /// then set showingConfirmation to true so the alert appears .
         /// If the decoding fails – if the server sent back something that wasn’t an order for some reason –
         /// we’ll just print an error message :
         
         if let _decodedOrder = try? JSONDecoder().decode(Order.self,
                                                         from: _data) {
            self.alertMessage = "You have ordered \(_decodedOrder.numberOfCakes) \(Order.cakeTypes[_decodedOrder.cakeTypeIndex].lowercased()) cakes."
            isShowingAlert.toggle()
         } else {
            print("There has been an invalid response from the server.")
         }
      }.resume()
      /*
       if let _data = data {
          if let _decodedResponse = try? JSONDecoder().decode(Response.self,
                                                              from: _data) {
             /// `4.1` We have good data , go back to the main thread :
             DispatchQueue.main.async {
                /// `4.2` Update our UI :
                self.results = _decodedResponse.results
             }
             /// `4.3` Everything is good , so we can exit :
             return
          }
       }
       /// `4.4` If we are still here , it means there was a problem :
       print("Fetch failed : \(error?.localizedDescription ?? "Unknown Error")")
       */
   }
}





// MARK: - PREVIEWS -

struct CheckoutView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      CheckoutView(order: Order())
   }
}
