import XCTest
@testable import TaskList

private final class TasksViewModelDelegateSpy: TasksViewModelDelegate {
    enum Message: Equatable {
        case displayLoadingState
        case displayTaskList(taskList: [Task])
        case displayError
    }
    
    private(set) var messages: [Message] = []
    
    func displayLoadingState() {
        messages.append(.displayLoadingState)
    }
    
    func displayTaskList(_ taskList: [Task]) {
        messages.append(.displayTaskList(taskList: taskList))
    }
    
    func displayError() {
        messages.append(.displayError)
    }
}

final class TasksViewModelTest: XCTestCase {
    private lazy var delegateSpy = TasksViewModelDelegateSpy()
    private lazy var sut: TasksViewModel = {
        let viewModel = TasksViewModel()
        viewModel.delegate = delegateSpy
        return viewModel
    }()
    
    func testLoadTaskList_WhenSucceed_ShouldCallDisplayTaskList() {
        sut.loadTaskList()
        
        XCTAssertEqual(delegateSpy.messages, [
            .displayLoadingState,
            .displayTaskList(taskList: TasksServiceMock.taskList)
        ])
    }
}
