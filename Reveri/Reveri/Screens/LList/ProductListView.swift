// 
//  ProductListView.swift
//  Reveri
//
//  Created by Alejandro Arjonilla Garcia on 22/2/23.
//

import SwiftUI

/// 
///
/// See design in [Figma]().
struct ProductListView: View {
    @StateObject var viewModel: ProductListViewModel

    init(viewModel: ProductListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.state == .loading {
                    Color.black.opacity(0.2)
                        .overlay {
                            ProgressView()
                        }
                        .ignoresSafeArea()
                }
                switch viewModel.state {
                case .error:
                    VStack {
                        // TODO: - This text should be localized in the proper string file
                        Text("Something went wrong, please try again")
                        Button("Try again") {
                            viewModel.fetchMore()
                        }
                    }
                case .loaded(let products):
                    List {
                        ForEach(products) { product in
                            Button(action: { viewModel.add(product: product.id) }) {
                                HStack {
                                    // TODO: - Add a cache system here to prevent loading everytime
                                    AsyncImage(url: URL(string: product.imageURL)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(25)
                                    VStack(alignment: .leading) {
                                        Text(product.title).font(.body)
                                        Text(product.description)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Text(product.price).font(.title2).fontWeight(.bold)
                                    Image(systemName: "plus")
                                }
                            }
                        }
                        if !viewModel.maxReached {
                            VStack(alignment: .center) {
                                ProgressView()
                                    .onAppear {
                                        viewModel.fetchMore()
                                    }
                            }
                        }
                    }
                default: EmptyView()
                }
            }
            .navigationBarItems(
                trailing: NavigationLink(
                    destination: {

                    },
                    label: {
                        Image(systemName: "cart.fill")
                            .foregroundColor(.primary)
                    }
                )
            )
        }
        // TODO: - I don't like this approach as everytime this screens appears for the user new data will be fetched
        .onAppear {
            viewModel.fetchMore()
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(
            viewModel: .init(state: .loading)
        )
        ProductListView(
            viewModel: .init(state: .error)
        )
        ProductListView(
            viewModel: .init(state: .loaded([
                .init(
                    id: 1,
                    imageURL: "",
                    title: "title",
                    description: "Description",
                    price: "1"
                )
            ]))
        )
    }
}
