import SwiftUI
struct CustomPickerView: View {
    @Binding var selection: String
    var options: [String]

    var body: some View {
        VStack {
            Picker("selecciona tu carrera", selection: $selection) {
                ForEach(options, id: \.self) { option in
                    Text(option)
                }
            }
            Text(selection)
                .font(.system(size: 15))
                .foregroundColor(Color.black)
                .padding()
                .frame(width: 328, height: 48)
                .background(Color.clear) // Elimina el fondo
                .padding(.top, 11)
                .padding(.bottom, 11)
                .padding(.horizontal, 29)
                .frame(maxWidth: .infinity, alignment: .leading) // Alinea el texto a la izquierda
        }
    }
}
