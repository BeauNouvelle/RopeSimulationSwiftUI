//
//  Stick.swift
//  DangleRope
//
//  Created by Beau Nouvelle on 3/1/2022.
//

import Foundation
import SwiftUI

class Stick: Identifiable {
    var id = UUID()

    var nodeA: Node
    var nodeB: Node
    var length: CGFloat
    var center: CGPoint {
        return (nodeA.position + nodeB.position) / 2
    }
    var direction: CGPoint {
        return (nodeA.position - nodeB.position).normalized()
    }

    init(nodeA: Node, nodeB: Node) {
        self.nodeA = nodeA
        self.nodeB = nodeB
        self.length = distance(nodeA.position, nodeB.position)
    }
}
