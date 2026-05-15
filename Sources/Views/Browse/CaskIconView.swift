import SwiftUI

struct CaskIconView: View {
    let token: String
    let size: CGFloat

    var body: some View {
        Image(systemName: "shippingbox.fill")
            .resizable().scaledToFit()
            .padding(size * 0.2)
            .foregroundStyle(.secondary)
            .frame(width: size, height: size)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: size * 0.18))
    }
}
