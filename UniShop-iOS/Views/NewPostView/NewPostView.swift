import SwiftUI
import FirebaseStorage
import Foundation

struct NewPostView: View {
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var price: String = ""
    @State private var subject: String = ""
    @State private var degree: String = ""
    @State private var isNewProduct: Bool = false
    @State private var selectedImage: Image? = nil
    @State private var selecteduiImage: UIImage? = nil
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
                    .onChange(of: name) { newValue in
                        if newValue.count > 50 {
                            name = String(newValue.prefix(50))
                        }
                    }
                
                if selectedImage != nil { // Mostrar la imagen si está seleccionada
                    selectedImage!
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
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
                        ImagePickerView(image: $selectedImage, uiImage: $selecteduiImage, sourceType: .camera)
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
                        ImagePickerView(image: $selectedImage, uiImage: $selecteduiImage, sourceType: .photoLibrary)
                    }
                }
                
                TextField("Description", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing], 15)
                    .onChange(of: description) { newValue in
                        if newValue.count > 100 {
                            description = String(newValue.prefix(100))
                        }
                    }
                
                TextField("Price", text: $price)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding([.leading, .trailing], 15)
                    .onChange(of: price) { newValue in
                        if newValue.count > 9 {
                            price = String(newValue.prefix(9))
                        }
                    }
                
                TextField("Subject", text: $subject)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing], 15)
                    .onChange(of: subject) { newValue in
                        if newValue.count > 20 {
                            subject = String(newValue.prefix(20))
                        }
                    }
                
                Group{
                    Text("Select your degree")
                        .offset(x: -getRelativeHeight(120))
                }
                Group{
                    
                    HStack {
                        Picker("ISIS", selection: $newPostViewModel.selectedCarrera) {
                            ForEach(["ISIS", "MATE", "ADMIN", "IND", "ARQUI", "ARTE", "DISE"], id: \.self) { carrera in
                                Text(carrera).tag(carrera)
                                    .foregroundColor(Color.blue)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: getRelativeWidth(328.0), height: getRelativeHeight(48.0), alignment: .leading)
                        .offset(x: -getRelativeHeight(20))
                        
                        
                    }}
                
                Group{
                    Text("Select the category of your product")
                        .offset(x: -getRelativeHeight(65))
                }
                Group{
                    
                    HStack {
                        Picker("Others", selection: $newPostViewModel.selectedCategory) {
                            ForEach(["Others","Computers",
                                     "Tablets",
                                     " Cell phones",
                                     "Small electronic supplies",
                                     "Electronic servomotors",
                                     "Electronic photocells",
                                     "Brushes",
                                     "Spheres",
                                     "Markers",
                                     "Paintings",
                                     "Canvases",
                                     "Chargers",
                                     "Clothes and accessories",
                                     "Furniture",
                                     "Home clothes"
                                    ], id: \.self) { carrera in
                                Text(carrera).tag(carrera)
                                    .foregroundColor(Color.blue)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: getRelativeWidth(328.0), height: getRelativeHeight(48.0), alignment: .leading)
                        .offset(x: -getRelativeHeight(20))
                        
                        
                    }}
                
                Toggle("New Product", isOn: $isNewProduct)
                    .padding([.leading, .trailing], 15)
                    .offset(x: getRelativeHeight(9))
                
                Button(action: {
                    
                    if  selectedImage == nil {
                        alertMessage = "Not published, you must select an image"
                        showAlert = true
                        isAlertSuccess = false
                        return
                    }
                    
                    else if allFieldsAreFilled() {
                        createNewPost()
                        
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
                
                if showAlert {
                        Text(alertMessage)
                            .foregroundColor(.white)
                            .padding()
                            .background(isAlertSuccess ? Color.green : Color.red)
                            .cornerRadius(10)
                            .opacity(showAlert ? 1 : 0)
                            .animation(.easeInOut(duration: 0.5))
                    }
            }
        }
    }
    func createNewPost() {
        var posturl = "https://i.pinimg.com/originals/80/b5/81/80b5813d8ad81a765ca47ebc59a65ac3.jpg"
        let uuid = UUID().uuidString
        if let data = selecteduiImage?.pngData() {
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentsDirectory.appendingPathComponent("\(uuid).png")
                do {
                    try data.write(to: fileURL)
                    uploadFile(fileUrl: fileURL){ url in
                        posturl = url
                        // Crear el objeto de solicitud JSON con los datos del formulario
                        let postData: [String: Any] = [
                            "object": [
                                "degree": newPostViewModel.selectedCarrera,
                                "category":newPostViewModel.selectedCategory,
                                "description": description,
                                "name": name,
                                "new": isNewProduct,
                                "price": Double(price) ?? 0.0,
                                "recycled": false, // Cambia a true si lo necesitas
                                "subject": subject,
                                "urlsImages": posturl, // Agrega la URL de la imagen aquí si es necesario
                                "userId": UserDefaults.standard.string(forKey: "userID") ?? "0" // Cambia al ID de usuario correcto
                            ]
                        ]
                        print(posturl)
                        
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
                    }
                    let defaults = UserDefaults.standard;
                    defaults.removeObject(forKey: "userPosts")
                    defaults.removeObject(forKey: "allProducts")
                    defaults.removeObject(forKey: "recommendedProducts")
                } catch {
                    // Handle the error
                    print("Error saving file: \(error)")
                }
            }
        }
        alertMessage = "Successfully published!"
        isAlertSuccess = true
        showAlert = true
        
    }
    func allFieldsAreFilled() -> Bool {
        // Verifica que name, description y subject no contengan solo espacios
        let validName = !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let validDescription = !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let validSubject = !subject.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let validPrice = !price.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        
        return validName && validDescription && validSubject && validPrice
    }
    
    func uploadFile(fileUrl: URL,  completion: @escaping (String) -> Void) {
        do {
            let fileExtension = fileUrl.pathExtension
            let uuid = UUID().uuidString
            let fileName = "\(uuid).\(fileExtension)"
            
            let storageReference = Storage.storage().reference().child(fileName)
            _ = storageReference.putFile(from: fileUrl, metadata: nil) { (storageMetaData, error) in
                if let error = error {
                    alertMessage = "Error uploading files: \(error.localizedDescription)"
                    showAlert = true
                } else {
                    // Show UIAlertController here
                    print("Image file: \(fileName) is uploaded! View it at Firebase console!")
                    
                    storageReference.downloadURL { (url, error) in
                        if let error = error  {
                            alertMessage = "Error uploading files: \(error.localizedDescription)"
                            showAlert = true
                        } else {
                            if let downloadURL = url?.absoluteString {
                                completion(downloadURL)
                            } else {
                                alertMessage = "Error generating files link"
                                showAlert = true                            }
                        }
                    }
                }
            }
        }
    }
    struct NewPostView_Previews: PreviewProvider {
        static var previews: some View {
            NewPostView()
        }
    }
    
}
