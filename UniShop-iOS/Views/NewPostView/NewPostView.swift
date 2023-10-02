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
                
                Button(action: {
                    isImagePickerPresented.toggle()
                }) {
                    HStack {
                        Image(systemName: "camera")
                        Text(selectedImage == nil ? "Add Image" : "Change Image") //
                    }
                    .foregroundColor(Color(red: 1, green: 0.776, blue: 0))
                }
                .frame(width: selectedImage == nil ? 350 : 200, height: selectedImage == nil ? 400 : 30)
                .cornerRadius(10)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 1, green: 0.776, blue: 0))
                )
                
                
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePickerView(image: $selectedImage)
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
                
                Toggle("New Product", isOn: $isNewProduct)
                    .padding([.leading, .trailing], 15)
                
                Button(action: {
                    createNewPost()
                }) {
                    Text("Post")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(red: 1, green: 0.776, blue: 0))
                        .cornerRadius(10)
                }
                .padding([.leading, .trailing], 15)
            }
            .padding(.bottom, 100)
        }
    }
    func createNewPost() {
        // Crear el objeto de solicitud JSON con los datos del formulario
        let postData: [String: Any] = [
            "object": [
                "date": "2023-09-27",
                "degree": degree,
                "description": description,
                "name": name,
                "new": isNewProduct,
                "price": Double(price) ?? 0.0,
                "recycled": false, // Cambia a true si lo necesitas
                "subject": subject,
                "urlsImages": "", // Agrega la URL de la imagen aquí si es necesario
                "userId": "b7e0f74e-debe-4dcc-8283-9d6a97e76166" // Cambia al ID de usuario correcto
            ]
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: postData) else {
            // Maneja el error de serialización de datos aquí
            return
        }
        
        guard let url = URL(string: "https://creative-mole-46.hasura.app/api/rest/post/create") else {
            // Maneja el error de URL incorrecta aquí
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
                    // Verifica si la creación de la publicación fue exitosa
                    if let dataResponse = json["data"] as? [String: Any] {
                        if let insertPostOne = dataResponse["insert_post_one"] as? [String: Any] {
                            // La publicación se creó con éxito
                            print("Publicación creada con éxito")
                            // Puedes realizar acciones adicionales aquí, como mostrar una alerta
                        } else if let errors = dataResponse["errors"] as? [[String: Any]] {
                            // Maneja los errores si ocurrieron durante la creación de la publicación
                            for error in errors {
                                if let message = error["message"] as? String {
                                    print("Error: \(message)")
                                }
                            }
                        }
                    }
                }
            } else if let error = error {
                print("Error en la solicitud: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    
    
    struct NewPostView_Previews: PreviewProvider {
        static var previews: some View {
            NewPostView()
        }
    }
    
}
