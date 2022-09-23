final class TasksServiceMock {
    static var taskList: [Task] {
        [
            Task(title: "A title", description: "A description"),
            Task(title: "A title", description: "A description"),
            Task(title: "A title", description: "A description"),
            Task(title: "A title", description: "A description")
        ]
    }
    
    private init() {}
}
