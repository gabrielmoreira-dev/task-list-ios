import UIKit

final class TasksViewController: UIViewController {
    private let cellIdentifier = String(describing: UITableViewCell.self)
    private let viewModel: TasksViewModel
    private var taskList: [Task] = []
    
    private lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundView = activity
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.loadTaskList()
    }
    
    init(viewModel: TasksViewModel = TasksViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

private extension TasksViewController {
    func configureView() {
        title = "Task List"
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = taskList[indexPath.row]
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if cell == nil {
            cell = UITableViewCell(style: .value2, reuseIdentifier: cellIdentifier)
        }
        
        cell?.textLabel?.text = task.title
        cell?.detailTextLabel?.text = task.description
        
        return cell ?? UITableViewCell()
    }
}

extension TasksViewController: TasksViewModelDelegate {
    func displayLoadingState() {
        activity.startAnimating()
    }
    
    func displayTaskList(_ taskList: [Task]) {
        self.taskList = taskList
        tableView.reloadData()
        activity.stopAnimating()
    }
    
    func displayError() {
        activity.stopAnimating()
    }
}
