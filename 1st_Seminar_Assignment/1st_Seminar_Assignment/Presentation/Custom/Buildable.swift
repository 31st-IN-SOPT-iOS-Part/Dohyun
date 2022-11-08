//
//  Buildable.swift
//  1st_Seminar_Assignment
//
//  Created by Jung peter on 10/13/22.
//

import UIKit

protocol Buildable {
    associatedtype ViewType
    func build(_ config: ((ViewType) -> Void)?) -> ViewType
}
