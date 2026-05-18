import Foundation
import Observation

@Observable
final class TableDemoStore {
    private(set) var rows: [StudentRow]
    var selection: Set<StudentRow.ID>
    var searchText: String
    var passingOnly: Bool
    var sortOrder: [KeyPathComparator<StudentRow>]

    init(
        rows: [StudentRow] = StudentRow.samples,
        selection: Set<StudentRow.ID> = [],
        searchText: String = "",
        passingOnly: Bool = false,
        sortOrder: [KeyPathComparator<StudentRow>] = [
            KeyPathComparator(\.score, order: .reverse),
            KeyPathComparator(\.name, order: .forward)
        ]
    ) {
        self.rows = rows
        self.selection = selection
        self.searchText = searchText
        self.passingOnly = passingOnly
        self.sortOrder = sortOrder
    }

    var visibleRows: [StudentRow] {
        let filtered = rows.filter { row in
            let matchesSearch = searchText.isEmpty
                || row.name.localizedCaseInsensitiveContains(searchText)
                || row.team.localizedCaseInsensitiveContains(searchText)
            let matchesPassing = !passingOnly || row.isPassing
            return matchesSearch && matchesPassing
        }

        return filtered.sorted(using: sortOrder)
    }

    var selectedRow: StudentRow? {
        guard let selectedID = selection.first else {
            return nil
        }
        return rows.first { $0.id == selectedID }
    }

    func addRow() {
        rows.append(.random(index: rows.count + 1))
    }

    func removeSelection() {
        guard !selection.isEmpty else {
            return
        }

        rows.removeAll { selection.contains($0.id) }
        selection.removeAll()
    }

    func resetDemo() {
        rows = StudentRow.samples
        selection.removeAll()
        searchText = ""
        passingOnly = false
        sortOrder = [
            KeyPathComparator(\.score, order: .reverse),
            KeyPathComparator(\.name, order: .forward)
        ]
    }
}
