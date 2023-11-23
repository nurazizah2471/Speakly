//
//  HomeView.swift
//  Speakly
//
//  Created by Nur Azizah on 22/11/23.
//

import SwiftData
import SwiftUI

extension View {
    func showTabItemStyle(selectedTab: Int, type: String, tag: Int) -> some View {
        self
            .tabItem {
                Image(systemName: getImage(selectedTab: selectedTab, tag: tag, type: type))
                    .environment(\.symbolVariants, .none)
                
                Text(type)
            }
            .tag(tag)
    }
    
    func getImage(selectedTab:Int, tag: Int, type: String) -> String {
        if type == "Latihan" {
            if selectedTab == tag {
                return "mic.fill"
            } else {
                return "mic"
            }
            
        } else if type == "Konsultasi" {
            if selectedTab == tag {
                return "heart.fill"
            } else {
                return "heart"
            }
        } else if type == "Tutorial" {
            if selectedTab == tag {
                return "arrowtriangle.right.fill"
            } else {
                return "arrowtriangle.right"
            }
        }
        else {
            if selectedTab == tag {
                return "person.crop.circle.fill"
            } else {
                return "person.crop.circle"
            }
        }
    }
}

struct HomeView: View {
    @Environment(\.userViewModel) private var userViewModel
    @Environment(\.wordPracticeViewModel) private var wordPracticeViewModel
    
    @State var isLoading: Bool = false
    @State var selectedTab = 0
    
    var body: some View {
        VStack {
            if userViewModel.userLogin == nil {
                SignInButtonView(isLoading: $isLoading)
            } else {
                if isLoading {
                    LoadingView(informationText: .constant("Wait for a moment..."))
                } else {
                    TabView(selection: $selectedTab) {
                        PracticeView()
                            .showTabItemStyle(selectedTab: selectedTab, type: "Latihan", tag: 0)
                        
                        BookingView()
                            .showTabItemStyle(selectedTab: selectedTab, type: "Konsultasi", tag: 1)
                        
                        TutorialView()
                            .showTabItemStyle(selectedTab: selectedTab, type: "Tutorial", tag: 2)
                        
                        AccountView()
                            .showTabItemStyle(selectedTab: selectedTab, type: "Akun", tag: 3)
                    }
                    .tint(Color(.blue))
                }
            }
        }
        .onAppear {
            userViewModel.setUserLogin("001051.65404d21a61e4da9856cc6189094fb3c.1023")
//            wordPracticeViewModel.deleteAllUser(userID: userViewModel.userLogin!.userID)
        }
    }
}

#Preview {
    HomeView()
}
