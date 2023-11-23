//
//  Routes.swift
//  Speakly
//
//  Created by Nur Azizah on 22/11/23.
//

import SwiftUI

enum Route: Hashable {
    case practiceWordIndependent
    case evaluationWord
    case evaluationWordIndependentView
}

// MARK: - Route view definition, set them here

/// Struct that stores all mappings of Views and Routes from Route Enum
struct Routes: View {
    let route: Route
    
    var body: some View {
        switch route {
        case .practiceWordIndependent:
            PracticeWordIndependentView()
        case .evaluationWord:
            EvaluationWordView()
        case .evaluationWordIndependentView:
            EvaluationWordIndependentView()
        }
    }
}

// MARK: - Route View Model

/// Route view model, should not change if not necessary
@Observable
class RouteViewModel {
    static var shared = RouteViewModel()

    var navPath = [Route]() {
        willSet {
            previousRoute = navPath.last
        }
    }

    private(set) var previousRoute: Route?
    var currentRoute: Route? {
        navPath.last
    }

    // MARK: - Append route to navigation path

    /// Append AKA go to next route
    func append(_ route: Route, before: (() -> Void)? = nil) {
        before?()
        navPath.append(route)
    }

    // MARK: - Pop route from navigation path

    /// Pop AKA return to previous view in the navigation stack
    func pop(before: (() -> Void)? = nil) {
        guard !navPath.isEmpty else {
            print("navPath is empty")
            return
        }
        before?()
        navPath.removeLast()
    }

    // MARK: - Pop multiple routes

    /// Pop multiple times AKA return to previous view multiple times in the navigation stack
    func pop(_ count: Int, before: (() -> Void)? = nil) {
        guard navPath.count >= count else {
            print("count must not be greater than navPath.count")
            return
        }
        before?()
        navPath.removeLast(count)
    }

    // MARK: - Pop to root

    /// Back to root view
    func popToRoot(before: (() -> Void)? = nil) {
        before?()
        navPath.removeLast(navPath.count)
    }

    // MARK: - Append multiple routes

    /// Append multiple routes to navigation stack
    func append(_ routes: Route..., before: (() -> Void)? = nil) {
        before?()
        routes.forEach { route in
            navPath.append(route)
        }
    }
}

// MARK: - Environments Definition

struct NavigationEnvironmentKey: EnvironmentKey {
    static var defaultValue: RouteViewModel = .init()
}

struct NavigateToRootEnvironmentKey: EnvironmentKey {
    static var defaultValue: RouteViewModel = .init()
}

extension EnvironmentValues {
    var navigate: RouteViewModel {
        get { self[NavigationEnvironmentKey.self] }
        set { self[NavigationEnvironmentKey.self] = newValue }
    }
}
