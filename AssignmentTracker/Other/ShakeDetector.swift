//
//  ShakeDetector.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 04..
//


import CoreMotion
import SwiftUI

class ShakeDetector: ObservableObject {
    private var motionManager: CMMotionManager?
    private var lastUpdate: Date?
    
    var onShake: () -> Void
    
    init(onShake: @escaping () -> Void) {
        self.onShake = onShake
    }
    
    func startShakeDetection() {
        motionManager = CMMotionManager()
        
        if let motionManager = motionManager, motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, error in
                guard let data = data, error == nil else { return }
                self?.detectShake(accelerationData: data)
            }
        }
    }
    
    func stopShakeDetection() {
        motionManager?.stopAccelerometerUpdates()
    }
    
    private func detectShake(accelerationData: CMAccelerometerData) {
        // Shake detection threshold
        let threshold: Double = 2.0
        
        // Detect shake based on rapid acceleration changes
        if let lastUpdate = lastUpdate, Date().timeIntervalSince(lastUpdate) < 0.5 {
            let acceleration = sqrt(accelerationData.acceleration.x * accelerationData.acceleration.x +
                                    accelerationData.acceleration.y * accelerationData.acceleration.y +
                                    accelerationData.acceleration.z * accelerationData.acceleration.z)
            
            if acceleration > threshold {
                self.onShake() // Shake detected
            }
        }
        
        lastUpdate = Date()
    }
}
