//
//  ViewModelType.swift
//  RxAppStore
//
//  Created by 이재희 on 4/6/24.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
