//
//  CartView.swift
//  Reveri
//
//  Created by Alejandro Arjonilla Garcia on 22/2/23.
//

import SwiftUI

struct CartView: View {

    @StateObject var viewModel: CartViewModel

    init(viewModel: CartViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        List {
            ForEach(viewModel.cells) { cell in
                HStack {
                    // TODO: - Add a cache system here to prevent loading everytime
                    AsyncImage(url: URL(string: cell.imageURL)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                    VStack(alignment: .leading) {
                        Text(cell.title).font(.body)
                    }
                    Spacer()
                    Text(cell.price).font(.title2).fontWeight(.bold)
                    Button(action: { viewModel.remove(product: cell.id) }) {
                        Image(systemName: "minus")
                    }
                    .disabled(cell.isMinusDisabled)
                    Text("\(cell.count)")
                    Button(action: { viewModel.add(product: cell.id) }) {
                        Image(systemName: "plus")
                    }
                    .disabled(cell.isPlusDisabled)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
        .navigationTitle("Cart")
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: .init(cells: [
            .init(
                id: 1,
                imageURL: "",
                title: "title",
                price: "1 USD",
                count: 1,
                stock: 4
            )
        ]))
    }
}
