import XCTest
@testable import TaskList

private final class TasksViewModelDelegateSpy: TasksViewModelDelegate {
    private(set) var displayLoadingStateCount = 0
    private(set) var displayErrorCount = 0
    private(set) var receivedTaskList: [Task] = []
    
    func displayLoadingState() {
        displayLoadingStateCount += 1
    }
    
    func displayTaskList(_ taskList: [Task]) {
        receivedTaskList = taskList
    }
    
    func displayError() {
        displayErrorCount += 1
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
        
        XCTAssertEqual(delegateSpy.displayLoadingStateCount, 1)
        XCTAssertEqual(delegateSpy.receivedTaskList, TasksServiceMock.taskList)
    }
}
