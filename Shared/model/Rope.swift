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
            node.position += CGPoint(x: 0, y: 0.196)
            node.previousPosition = prevPos
        }

        for stick in sticks {
            let stickCenter = stick.center
            let stickDirection = stick.direction

            if !stick.nodeA.locked {
                stick.nodeA.position = stickCenter + stickDirection * stick.length / 2
                stick.nodeA.position = CGPoint(x: stick.nodeA.position.x.clamped(to: 5...1195), y: stick.nodeA.position.y.clamped(to: 5...895))
            }

            if !stick.nodeB.locked {
                stick.nodeB.position = stickCenter - stickDirection * stick.length / 2

                stick.nodeB.position = CGPoint(x: stick.nodeB.position.x.clamped(to: 5...1195), y: stick.nodeB.position.y.clamped(to: 5...895))
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

extension Strideable where Stride: SignedInteger {
    func clamped(to limits: CountableClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
