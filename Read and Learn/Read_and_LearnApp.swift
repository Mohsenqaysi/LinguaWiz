//
//  Read_and_LearnApp.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 5/1/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct Read_and_LearnApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment (\.scenePhase) private var scenePhase
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 0.1, on: .main, in: .common)
    @State var timeSpent = 0.0
    
    func startTimer() {
        print("Strting time: \(timeSpent)")
        timer = Timer.publish(every: 0.1, on: .main, in: .common)
        _ = timer.connect()
    }
    
    func stopTimer() {
        print("Current time spent: \(String(format: "%.1f", timeSpent))")
        print("Data: \(Date().description)")
        timeSpent = 0.0
        timer.connect().cancel()
    }
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .overlay(alignment: .bottom) {
                    Text(String(format: "%.1f", timeSpent))
                        .hidden()
                        .disabled(true)
                        .onReceive(timer) { _ in
                            timeSpent += 0.1
                            //                            print(String(format: "%.1f", timeSpent))
                        }
                }
                .preferredColorScheme(.light)
                .onChange(of: scenePhase) { newPhase in
                    switch newPhase {
                    case .active:
                        print("App is active")
                        startTimer()
                    case .background:
                        print("App is in background")
                        stopTimer()
                    case .inactive:
                        print("App is inactive")
                    @unknown default:
                        fatalError("Something went wrong")
                    }
                }
        }
    }
}
