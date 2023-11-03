import SwiftUI

struct NewPostView: View {
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var price: String = ""
    @State private var subject: String = ""
    @State private var degree: String = ""
    @State private var isNewProduct: Bool = false
    @State private var selectedImage: Image? = nil
    @State private var isImagePickerPresented: Bool = false
    @State private var isImageSelected: Bool = false
    @StateObject var newPostViewModel = NewPostViewModel()
    @State private var isAlertPresented = false
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var isAlertSuccess = false
    @State private var invalidDegreeAlert = false
    @State private var isCameraPickerPresented = false
    @State private var isGalleryPickerPresented = false
    
    var body: some View {
        ScrollView {
            VStack() {
                Text("New Post")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .trailing], 15)
                
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing], 15)
                
                if selectedImage != nil { // Mostrar la imagen si está seleccionada
                    selectedImage!
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                }
                
                HStack {
                    Button(action: {
                        isCameraPickerPresented.toggle()
                    }) {
                        HStack {
                            Image(systemName: "camera")
                            Text("Camera")
                        }
                        .foregroundColor(Color(red: 1, green: 0.776, blue: 0))
                    }
                    .frame(maxWidth: .infinity)
                    .padding([.leading, .trailing], 15)
                    .sheet(isPresented: $isCameraPickerPresented) {
                        ImagePickerView(image: $selectedImage, sourceType: .camera)
                    }
                    
                    Button(action:  {
                        isGalleryPickerPresented.toggle()
                    }) {
                        HStack {
                            Image(systemName: "photo")
                            Text("Gallery")
                        }
                        .foregroundColor(Color(red: 1, green: 0.776, blue: 0))
                    }
                    .frame(maxWidth: .infinity)
                    .padding([.leading, .trailing], 15)
                    .sheet(isPresented: $isGalleryPickerPresented) {
                        ImagePickerView(image: $selectedImage, sourceType: .photoLibrary)
                    }
                }
                
                TextField("Description", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing], 15)
                
                TextField("Price", text: $price)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding([.leading, .trailing], 15)
                
                TextField("Subject", text: $subject)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing], 15)
                
                TextField("Degree", text: $degree)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing], 15)
                    .onChange(of: degree) { newValue in
                        if newValue.count != 4 {
                            degree = String(newValue.prefix(4))
                        }
                        degree = degree.uppercased()
                    }
                
                Toggle("New Product", isOn: $isNewProduct)
                    .padding([.leading, .trailing], 15)
                
                Button(action: {
                    
                    if allFieldsAreFilled() {
                        createNewPost()
                    }
                    else if degree.count != 4 || degree.contains(" "){
                        alertMessage = "Not published, the degree must be 4 letters"
                        showAlert = true
                        isAlertSuccess = false
                        return
                    }
                    else if selectedImage == nil {
                        alertMessage = "Not published, you must select an image"
                        showAlert = true
                        isAlertSuccess = false
                        return
                    }
                    else {
                        alertMessage = "Not published, empty fields or incorrect values"
                        showAlert = true
                        isAlertSuccess = false
                    }
                }) {
                    Text("Post")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(red: 1, green: 0.776, blue: 0))
                        .cornerRadius(10)
                }
                .padding([.leading, .trailing], 15)
                
                .onTapGesture {
                    if allFieldsAreFilled() {
                        createNewPost()
                        
                    } else {
                        alertMessage = "Not published, empty fields or incorrect values"
                        showAlert = true
                        isAlertSuccess = false
                    }
                }
                
                .overlay(
                    Text(alertMessage)
                        .foregroundColor(.white)
                        .padding()
                        .background(isAlertSuccess ? Color.green : Color.red) // Ajusta el color aquí
                        .cornerRadius(10)
                        .opacity(showAlert ? 1 : 0)
                        .animation(.easeInOut(duration: 0.5))
                )
            }
        }
    }
    func createNewPost() {
        
        var url = "https://i.pinimg.com/originals/80/b5/81/80b5813d8ad81a765ca47ebc59a65ac3.jpg"
        
        // Crear el objeto de solicitud JSON con los datos del formulario
        let postData: [String: Any] = [
            "object": [
                "degree": degree,
                "description": description,
                "name": name,
                "new": isNewProduct,
                "price": Double(price) ?? 0.0,
                "recycled": false, // Cambia a true si lo necesitas
                "subject": subject,
                "urlsImages": url, // Agrega la URL de la imagen aquí si es necesario
                "userId": UserDefaults.standard.string(forKey: "userID") // Cambia al ID de usuario correcto
            ]
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: postData) else {
            
            return
        }
        
        guard let url = URL(string: "https://creative-mole-46.hasura.app/api/rest/post/create") else {
            
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("mmjEW9L3cf3SZ0cr5pb6hnnnFp1ud4CB4M6iT1f0xYons16k2468G9SqXS9KgdAZ", forHTTPHeaderField: "x-hasura-admin-secret")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let dataResponse = json["data"] as? [String: Any] {
                        if let insertPostOne = dataResponse["insert_post_one"] as? [String: Any] {
                            alertMessage = "Publicación creada con éxito"
                            showAlert = true
                            let defaults = UserDefaults.standard;
                            defaults.removeObject(forKey: "userPosts")
                            defaults.removeObject(forKey: "allProducts")
                            defaults.removeObject(forKey: "recommendedProducts")
                        } else if let errors = dataResponse["errors"] as? [[String: Any]] {
                            for error in errors {
                                if let message = error["message"] as? String {
                                    alertMessage = "Error: \(message)"
                                    showAlert = true
                                }
                            }
                        }
                    }
                }
            } else if let error = error {
                alertMessage = "Error en la solicitud: \(error.localizedDescription)"
                showAlert = true
            }
        }.resume()
        alertMessage = "Successfully published!"
        isAlertSuccess = true
        showAlert = true
        let defaults = UserDefaults.standard;
        defaults.removeObject(forKey: "userPosts")
        defaults.removeObject(forKey: "allProducts")
        defaults.removeObject(forKey: "recommendedProducts")
    }
    func allFieldsAreFilled() -> Bool {
        // Verifica que name, description y subject no contengan solo espacios
        let validName = !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let validDescription = !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let validSubject = !subject.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let validDegree = degree.count == 4 && degree.rangeOfCharacter(from: CharacterSet.letters) != nil && degree.rangeOfCharacter(from: CharacterSet.whitespaces) == nil
        let validPrice = !price.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        
        return validName && validDescription && validSubject && validDegree && validPrice
    }
    
    struct NewPostView_Previews: PreviewProvider {
        static var previews: some View {
            NewPostView()
        }
    }
    
}
