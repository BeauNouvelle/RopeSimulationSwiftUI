//
//  ContentView.swift
//  Shared
//
//  Created by Beau Nouvelle on 3/1/2022.
//

import SwiftUI

struct ContentView: View {

    @StateObject var rope = Rope()

    var body: some View {
        GeometryReader { reader in
            ZStack {
                if rope.updater {
                    ropeView
                } else {
                    ropeView
                }
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .background(.blue)
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onEnded { drag in
                    let newNode = Node(position: drag.location, locked: rope.nodes.isEmpty)
                    if let lastNode = rope.nodes.last {
                        let newStick = Stick(nodeA: lastNode, nodeB: newNode)
                        rope.sticks.append(newStick)
                    }
                    rope.nodes.append(newNode)
                }
        )
        .toolbar {
            Button {
                rope.toggleSimulation()
            } label: {
                Text(rope.isRunning ? "Stop" : "Start")
                    .foregroundColor(.white)
            }

            Button {
                rope.reset()
            } label: {
                Text("Reset")
                    .foregroundColor(.red)
            }

        }
    }

    @ViewBuilder
    var ropeView: some View {
        ForEach(rope.nodes) { node in
            NodeView(node: node)
        }
        ForEach(rope.sticks) { stick in
            StickView(stick: stick)
        }
    }
}
