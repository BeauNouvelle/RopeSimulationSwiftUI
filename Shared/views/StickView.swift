//
//  StickView.swift
//  DangleRope
//
//  Created by Beau Nouvelle on 3/1/2022.
//

import Foundation
import SwiftUI

struct StickView: View {
    var stick: Stick
    var body: some View {
        Path { path in
            path.move(to: stick.nodeA.position)
            path.addLine(to: stick.nodeB.position)
        }
        .strokedPath(.init(lineWidth: 4, lineCap: .round, dash: [5], dashPhase: 10))
    }
}
