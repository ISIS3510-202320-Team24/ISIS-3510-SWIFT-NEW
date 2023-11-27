
import SwiftUI
import MessageUI

struct ContactSellerView: View {
    let sellerName: String
    let phoneNumber: String // Add seller's phone number as a parameter
    
    var body: some View {
        VStack {
            Text("Contact Seller")
                .font(.largeTitle)
                .foregroundColor(Color(red: 1, green: 0.776, blue: 0))
                .padding(.bottom, 20)
            
            Image(systemName: "person.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.blue)
            
            Text("Seller Name:")
                .font(.headline)
                .padding(.top, 20)
            
            Text(sellerName)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 30)
            
            Text("Phone Number:")
                .font(.headline)
            
            Text(phoneNumber) // Display seller's phone number
                .font(.title)
                .padding(.bottom, 30)
            
            Button(action: {
            
            }) {
                Text("Call Seller")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.23, green: 0.23, blue: 0.23))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}


