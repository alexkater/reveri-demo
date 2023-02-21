// 
//  ProductListViewModel.swift
//  Reveri
//
//  Created by Alejandro Arjonilla Garcia on 22/2/23.
//

import Combine
import Foundation

final class ProductListViewModel: ObservableObject {

    struct CellViewModel {

    }

    enum State {
        case loaded([CellViewModel])
        case loading
        case error
    }

    @Published var state = State.loading
    
    init(state: State = State.loading) {
        self.state = state
    }
}
