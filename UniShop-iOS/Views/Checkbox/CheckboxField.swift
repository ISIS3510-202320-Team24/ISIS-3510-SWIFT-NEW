

import SwiftUI

struct CheckboxField: View {
    let idValue: String
    let label: String
    var size: CGFloat = 15
    var color: Color = .blue
    var textSize: Int = 14
    @Binding var isMarked: Bool

    var body: some View {
        Button(action: {
            self.isMarked.toggle()
        }, label: {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.isMarked ? "checkmark.square" : "square")
                    .resizable()
                    .renderingMode(.template).colorMultiply(self.color)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(label)
                    .font(Font.system(size: size))
                Spacer()
            }.foregroundColor(self.color)
        })
        .foregroundColor(Color.white)
    }
}

struct CheckboxField_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxField(idValue: "radio", label: "I am Visible?", isMarked: .constant(true))
    }
}
