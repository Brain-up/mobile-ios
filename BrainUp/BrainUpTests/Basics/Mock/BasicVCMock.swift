//
//  BasicVC_Mock.swift
//  BrainUpTests
//
//  Created by Evgenii Zhigunov on 3/14/22.
//

import Foundation
@testable import BrainUp

class BasicVCMock: BasicViewInterface {
    var isLoading: Bool = false
    var isShowingError: Bool = false
    var errorMessage: String = ""
    
    func showLoading() {
        isLoading = true
    }
    
    func hideLoading() {
        isLoading = false
    }
    
    func showError(errorMessage: String?) {
        isShowingError = true
        self.errorMessage = errorMessage ?? ""
    }
    
    func hideError() {
        isShowingError = false
        errorMessage = ""
    }
}
