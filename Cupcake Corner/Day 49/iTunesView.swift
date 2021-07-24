// iTunesView.swift
// SOURCE: https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-codable-data-with-urlsession-and-swiftui

import SwiftUI

// MARK: - Response STRUCT -

struct Response: Codable {
   
   var results: [Result]
}





// MARK: - Result STRUCT -

struct Result: Codable {
   
   let trackId: Int
   let trackName: String
   let collectionName: String
}





// MARK: - iTunesView STRUCT -

struct iTunesView: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   @State private var results = Array<Result>()
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      List {
         ForEach(results,
                 id: \.trackId) { (result: Result) in
            VStack(alignment: .leading) {
               Text(result.trackName)
                  .font(.headline)
               Text(result.collectionName)
                  .font(.subheadline)
            }
         }
      }
      .onAppear(perform: loadData)
      /// `1` We want `loadData` to be run as soon as our `List` is shown .
   }
   
   
   
   // MARK: METHODS
   
   /** HIGH LEVEL OVERVIEW :
    `STEP 1` : Ask the iTunes API to send us a list of all the songs by Taylor Swift .
    `STEP 2` : Then use JSONDecoder to convert those results into an array of Result instances .
    */
   func loadData() {
      
      /// `2` Creates  the URL we want to read .
      let taylorSwiftURL: String = "https://itunes.apple.com/search?term=taylor+swift&entity=song"
      
      guard let _url = URL(string: taylorSwiftURL)
      else {
         print("Invalid URL")
         return
      }
      
      /// `3` Wraps the URL in a `URLRequest`,
      /// which allows us to configure how the URL should be accessed .
      let urlRequest = URLRequest(url: _url)
      
      /// `4` Creates and starts a networking task from that URL request .
      /// Handles the result of that networking task .
      /// `URLSession` is the iOS class responsible for managing network requests .
      /// It is very common to use the `shared` session that iOS creates for us to use .
      URLSession.shared.dataTask(with: urlRequest) {(data: Data?,
                                                     urlResponse: URLResponse?,
                                                     error: Error?) in
         
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
      }.resume()
      
      URLSession.shared.dataTask(with: urlRequest) {data, response, error in
         
      }.resume()
   }
}





// MARK: - PREVIEWS -

struct iTunesView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      iTunesView()
   }
}
