import SwiftUI
import Foundation
import MessageUI

struct ContactSellerView: View {
    let sellerName: String
    let phoneNumber: String
    
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
            
            Text(phoneNumber)
                .font(.title)
                .padding(.bottom, 30)
            
            Button(action: {
                if let url = URL(string: "tel://\(phoneNumber)") {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Call Seller")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 1, green: 0.776, blue: 0))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
