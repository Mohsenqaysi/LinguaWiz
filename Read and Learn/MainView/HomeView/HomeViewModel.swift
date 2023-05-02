//
//  HomeViewModel.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 5/1/23.
//

import Foundation
struct Level {
    let title: String
    let subTitle: String
    let icon: String
    let unlocked: Bool

    init(_ title: String, subTitle: String, icon: String, unlocked: Bool) {
        self.title = title
        self.subTitle = subTitle
        self.icon = icon
        self.unlocked = unlocked
    }
}


class HomeViewModel: ObservableObject {

    init() {}
}

// MARK: VARS
extension HomeViewModel {
    var name: String {
        return "Hi Amal, Welcome"
    }
    var levels: [Level] {
        return [
            Level("Level One", subTitle: "A1 - A2", icon: levelOneIcon, unlocked: true),
            Level("Level Two", subTitle: "B1 - B2", icon: levelTwoIcon, unlocked: false),
            Level("Level Three", subTitle: "C1 - C2", icon: levelThreeIcon, unlocked: false),
            Level("Level Four", subTitle: "D1 - D2", icon: levelFourIcon, unlocked: false),
        ]
    }
}

// MARK: Titles
extension HomeViewModel{}

// MARK: Icons
extension HomeViewModel {
    var levelOneIcon: String { "levelOneIcon" }
    var levelTwoIcon: String { "levelTwoIcon" }
    var levelThreeIcon: String { "levelThreeIcon" }
    var levelFourIcon: String { "levelFourIcon" }
    var lockIcon: String { "lockIcon" }
    var activeLevelIcon: String { "activeLevelIcon" }
    var headerIcon: String { "headerIcon" }
    var buttonIcon: String { "buttonIcon" }
}
