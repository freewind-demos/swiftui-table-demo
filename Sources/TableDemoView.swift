import SwiftUI

struct TableDemoView: View {
    @Environment(TableDemoStore.self) private var store

    var body: some View {
        NavigationSplitView {
            TableMasterPane(store: store)
            .navigationTitle("Table Demo")
        } detail: {
            TableDetailPane(row: store.selectedRow)
                .padding(20)
                .navigationTitle("Inspector")
        }
    }
}

private struct TableMasterPane: View {
    @Bindable var store: TableDemoStore

    var body: some View {
        let rows = store.visibleRows

        VStack(spacing: 12) {
            TableSummaryCard(rows: rows)
            StudentTable(
                rows: rows,
                selection: $store.selection,
                sortOrder: $store.sortOrder,
                searchText: $store.searchText
            )
        }
        .padding(16)
        .toolbar {
            TableToolbar(store: store)
        }
    }
}

private struct StudentTable: View {
    let rows: [StudentRow]
    @Binding var selection: Set<StudentRow.ID>
    @Binding var sortOrder: [KeyPathComparator<StudentRow>]
    @Binding var searchText: String

    var body: some View {
        Table(rows, selection: $selection, sortOrder: $sortOrder) {
            TableColumn("Name", value: \.name)
            TableColumn("Team", value: \.team)
            TableColumn("Score", value: \.score, content: scoreCell)
            TableColumn("Tasks", content: tasksCell)
            TableColumn("Joined", content: joinedCell)
            TableColumn("State", content: stateCell)
        }
        .searchable(text: $searchText, prompt: "Search name or team")
        .frame(minWidth: 680, minHeight: 420)
    }

    private func scoreCell(row: StudentRow) -> some View {
        Text("\(row.score)")
            .fontWeight(row.isPassing ? .semibold : .regular)
            .foregroundStyle(row.isPassing ? Color.primary : Color.orange)
    }

    private func tasksCell(row: StudentRow) -> some View {
        Text("\(row.tasksDone)")
    }

    private func joinedCell(row: StudentRow) -> some View {
        Text(row.joinedAt, format: .dateTime.year().month().day())
            .foregroundStyle(.secondary)
    }

    private func stateCell(row: StudentRow) -> some View {
        Label(
            row.isPassing ? "Pass" : "Watch",
            systemImage: row.isPassing ? "checkmark.circle.fill" : "exclamationmark.circle"
        )
        .labelStyle(.titleAndIcon)
        .foregroundStyle(row.isPassing ? .green : .orange)
    }
}

private struct TableToolbar: ToolbarContent {
    @Bindable var store: TableDemoStore

    var body: some ToolbarContent {
        ToolbarItemGroup {
            Toggle("Pass Only", isOn: $store.passingOnly)
            Button("Add Row") {
                store.addRow()
            }
            Button("Delete Selected") {
                store.removeSelection()
            }
            .disabled(store.selection.isEmpty)
            Button("Reset") {
                store.resetDemo()
            }
        }
    }
}

private struct TableSummaryCard: View {
    let rows: [StudentRow]

    var body: some View {
        let passingCount = rows.filter(\.isPassing).count
        let avgScore = rows.isEmpty ? 0 : rows.map(\.score).reduce(0, +) / rows.count

        return HStack(spacing: 12) {
            SummaryMetric(title: "Visible", value: "\(rows.count)")
            SummaryMetric(title: "Passing", value: "\(passingCount)")
            SummaryMetric(title: "Avg Score", value: "\(avgScore)")
            Spacer(minLength: 0)
        }
    }
}

private struct SummaryMetric: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.title2.weight(.semibold))
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(.quaternary.opacity(0.5), in: RoundedRectangle(cornerRadius: 12))
    }
}

private struct TableDetailPane: View {
    let row: StudentRow?

    var body: some View {
        Group {
            if let row {
                VStack(alignment: .leading, spacing: 16) {
                    Text(row.name)
                        .font(.largeTitle.bold())
                    LabeledContent("Team", value: row.team)
                    LabeledContent("Score", value: "\(row.score)")
                    LabeledContent("Tasks", value: "\(row.tasksDone)")
                    LabeledContent("Joined") {
                        Text(row.joinedAt, format: .dateTime.year().month().day())
                    }
                    LabeledContent("State", value: row.isPassing ? "Pass" : "Watch")
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            } else {
                ContentUnavailableView(
                    "Select a row",
                    systemImage: "tablecells",
                    description: Text("Use the table on the left to inspect one record.")
                )
            }
        }
    }
}
