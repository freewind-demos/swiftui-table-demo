import SwiftUI

@main
struct SwiftUITableDemoApp: App {
    @State private var store = TableDemoStore()

    var body: some Scene {
        WindowGroup("swiftui-table-demo") {
            TableDemoView()
                .environment(store)
        }
        .windowResizability(.contentSize)
    }
}
