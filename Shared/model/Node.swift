//
//  Node.swift
//  DangleRope
//
//  Created by Beau Nouvelle on 3/1/2022.
//

import Foundation
import SwiftUI

class Node: Identifiable {
    var id = UUID()

    var position: CGPoint
    var previousPosition: CGPoint
    var locked: Bool

    init(position: CGPoint, locked: Bool) {
        self.position = position
        self.locked = locked
        self.previousPosition = .zero
    }
}

