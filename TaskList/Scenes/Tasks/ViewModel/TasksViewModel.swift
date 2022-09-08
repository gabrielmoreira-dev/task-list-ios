protocol TasksViewModelDelegate: AnyObject {
    func displayLoadingState()
    func displayTaskList(_ taskList: [Task])
    func displayError()
}

final class TasksViewModel {
    weak var delegate: TasksViewModelDelegate?
    
    func loadTaskList() {
        delegate?.displayLoadingState()
        let taskList = TasksServiceMock.taskList
        delegate?.displayTaskList(taskList)
    }
}
