// Validating and Disabling Forms.swift

import SwiftUI



struct Validating_and_Disabling_Forms: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   @State private var name: String = ""
   @State private var email: String = ""
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var buttonIsDisabled: Bool {
      
      return email.count < 5 || name.count < 5
   }
   
   
   var body: some View {
      
      Form {
         Section(header: Text("username and email")) {
            TextField("Your username is ...",
                      text: $name)
            TextField("Your email is ...",
                      text: $email)
         }
         .padding(.vertical)
         .textFieldStyle(RoundedBorderTextFieldStyle())
         HStack {
            Spacer()
            Button("Create Account") {
               print("The button is tapped .")
            }
            Spacer()
         }
         .padding()
         // .disabled(name.isEmpty || email.isEmpty)
         .disabled(buttonIsDisabled)
      }
   }
}





// MARK: - PREVIEWS -

struct Validating_and_Disabling_Forms_Previews: PreviewProvider {
   
   static var previews: some View {
      
      Validating_and_Disabling_Forms()
   }
}
