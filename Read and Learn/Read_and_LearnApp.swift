//
//  Read_and_LearnApp.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 5/1/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Firebase

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
    
    @State var userID = ""
    
    func startTimer() {
        print("Strting time: \(timeSpent)")
        timer = Timer.publish(every: 0.1, on: .main, in: .common)
        _ = timer.connect()
    }
    
    func stopTimer() {
        print("Current time spent: \(String(format: "%.1f", timeSpent))")
        print("Data: \(Date().description)")
        timer.connect().cancel()
    }
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .onReceive(timer) { _ in
                    timeSpent += 0.1
                }
                .onAppear {
                    fetchUserID()
                }
                .preferredColorScheme(.light)
                .onChange(of: scenePhase) { newPhase in
                    switch newPhase {
                    case .active:
                        print("App is active")
                        startTimer()
                        print("fetchUserID: \(userID)")
                    case .background:
                        print("App is in background")
//                        createSession(timeSpent)
                    case .inactive:
                        print("App is inactive")
                        if timeSpent != 0.0 {
                            createSession(timeSpent)
                        }
                    @unknown default:
                        createSession(timeSpent)
                        fatalError("Something went wrong")
                    }
                }
        }
    }
    
    func fetchUserID() {
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else { return }
            print("fetchUserID uid: \(user.uid)")
            self.userID = user.uid
        }
    }
    
    private func createSession(_ time: Double) {
        let db = Firestore.firestore()
        let docRef = db.collection("Sessions").document(userID)

        let data: [String : Any] = [Date().description : String(format: "%.3f", timeSpent)]
        docRef.setData(data, merge: true) { error in
            if let error = error {
                timeSpent = 0.0
                print("Error writing document: \(error)")
            } else {
                timeSpent = 0.0
                print("Document successfully written!")
            }
            stopTimer()
        }
    }
}
