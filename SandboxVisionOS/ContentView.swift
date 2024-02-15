//
//  ContentView.swift
//  SandboxVisionOS
//
//  Created by 홍성범 on 2/13/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @State private var birthRate: Float = 100
    @State private var width: Float = 0.1

    
    var body: some View {
        VStack {
            RealityView { content in
                if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                    content.add(scene)
                }
            } update: { content in
                guard let scene = content.entities.first else { return }
                let particleEntity = scene.findEntity(named: "Magic")
                guard var particles = particleEntity?.components[ParticleEmitterComponent.self] else { return }
                
                particles.mainEmitter.birthRate = birthRate
                particles.emitterShapeSize = [width, particles.emitterShapeSize.y, particles.emitterShapeSize.z]

                particleEntity?.components.set(particles)
            }
            
            LabeledContent("Birth rate") {
                Slider(value: $birthRate, in: 1...1000)
            }
            
            LabeledContent("Width") {
                Slider(value: $width, in: 0...5)
            }
        }
    }
}

#Preview {
    ContentView()
}
