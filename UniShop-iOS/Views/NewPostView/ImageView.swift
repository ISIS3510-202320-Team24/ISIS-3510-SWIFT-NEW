import SwiftUI

struct ImageView: View {
    let url: URL

    var body: some View {
        // Aquí puedes cargar y mostrar la imagen desde la URL
        // Puedes usar una biblioteca como SDWebImage o AlamofireImage para cargar imágenes desde una URL, o implementar tu propia lógica para hacerlo.
        // A continuación, se muestra un ejemplo simple utilizando la biblioteca SDWebImage:

        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                // La imagen aún no se ha cargado
                ProgressView()
            case .success(let image):
                // La imagen se cargó correctamente
                image
                    .resizable()
                    .scaledToFit()
            case .failure:
                // Se produjo un error al cargar la imagen
                Text("Error al cargar la imagen")
            @unknown default:
                // Maneja otros casos si es necesario
                EmptyView()
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        // Ejemplo de vista previa con una URL de imagen ficticia
        ImageView(url: URL(string: "https://example.com/image.jpg")!)
    }
}
