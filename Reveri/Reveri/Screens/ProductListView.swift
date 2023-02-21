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
    @StateObject var store: ProductListViewModel

    init(viewModel: ProductListViewModel) {
        _store = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Text("ProductListView")
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(
            viewModel: .init()
        )
    }
}
