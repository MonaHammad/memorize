//
//  Array+Only.swift
//  Memorize
//
//  Created by Mona Hammad on 8/6/20.
//  Copyright © 2020 Mona Hammad. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
