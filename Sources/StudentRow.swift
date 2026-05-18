import Foundation

struct StudentRow: Identifiable, Hashable {
    let id: UUID
    var name: String
    var team: String
    var score: Int
    var tasksDone: Int
    var joinedAt: Date

    var isPassing: Bool {
        score >= 80
    }

    static let samples: [StudentRow] = [
        StudentRow(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000001") ?? UUID(),
            name: "Ava",
            team: "Platform",
            score: 96,
            tasksDone: 14,
            joinedAt: .now.addingTimeInterval(-86_400 * 120)
        ),
        StudentRow(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000002") ?? UUID(),
            name: "Mason",
            team: "Design",
            score: 81,
            tasksDone: 10,
            joinedAt: .now.addingTimeInterval(-86_400 * 95)
        ),
        StudentRow(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000003") ?? UUID(),
            name: "Harper",
            team: "Growth",
            score: 74,
            tasksDone: 8,
            joinedAt: .now.addingTimeInterval(-86_400 * 80)
        ),
        StudentRow(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000004") ?? UUID(),
            name: "Ethan",
            team: "Infra",
            score: 88,
            tasksDone: 11,
            joinedAt: .now.addingTimeInterval(-86_400 * 65)
        ),
        StudentRow(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000005") ?? UUID(),
            name: "Luna",
            team: "QA",
            score: 92,
            tasksDone: 13,
            joinedAt: .now.addingTimeInterval(-86_400 * 40)
        ),
        StudentRow(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000006") ?? UUID(),
            name: "Noah",
            team: "Security",
            score: 67,
            tasksDone: 6,
            joinedAt: .now.addingTimeInterval(-86_400 * 25)
        )
    ]

    static func random(index: Int) -> StudentRow {
        let names = ["Olivia", "Elijah", "Sophia", "James", "Isabella", "Lucas"]
        let teams = ["Platform", "Design", "Growth", "Infra", "QA", "Security"]

        return StudentRow(
            id: UUID(),
            name: names[index % names.count],
            team: teams[index % teams.count],
            score: 68 + (index * 7 % 31),
            tasksDone: 4 + (index * 3 % 12),
            joinedAt: .now.addingTimeInterval(-86_400 * Double(5 + index * 2))
        )
    }
}
