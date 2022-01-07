//
//  Rope.swift
//  DangleRope
//
//  Created by Beau Nouvelle on 3/1/2022.
//

import Foundation
import SwiftUI

class Rope: ObservableObject {
    @Published var nodes: [Node] = []
    @Published var sticks: [Stick] = []
    @Published var isRunning: Bool = false
    @Published var updater: Bool = false

    var timer: Timer?

    func update() {
        for node in nodes {
            guard !node.locked else {
                continue
            }
            let prevPos = node.position
            node.position += node.position - node.previousPosition
            node.position += CGPoint(x: 0, y: 9.8)
            node.previousPosition = prevPos
        }
        for stick in sticks {
            let stickCenter = stick.center
            let stickDirection = stick.direction

            if !stick.nodeA.locked {
                stick.nodeA.position = stickCenter + stickDirection * stick.length / 2
            }

            if !stick.nodeB.locked {
                stick.nodeB.position = stickCenter - stickDirection * stick.length / 2
            }
        }
    }

    func toggleSimulation() {
        if timer?.isValid == true {
            timer?.invalidate()
            isRunning = false
        } else {
            isRunning = true
            timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { timer in
                self.updater.toggle()
                self.update()
            })
        }
    }

    func reset() {
        if isRunning {
            toggleSimulation()
        }
        nodes = []
        sticks = []
    }
}

