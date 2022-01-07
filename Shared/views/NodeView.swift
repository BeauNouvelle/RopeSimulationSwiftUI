//
//  NodeView.swift
//  DangleRope
//
//  Created by Beau Nouvelle on 3/1/2022.
//

import Foundation
import SwiftUI

struct NodeView: View {
    var node: Node
    var body: some View {
        Circle()
            .frame(width: 15, height: 15)
            .foregroundColor(node.locked ? .red : .green)
            .position(node.position)
    }
}
