class FeedViewController: UIViewController {
    
    var posts: [Post] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshFeed() {
        queryPosts()
    }
    
    func queryPosts() {
        let query = Post.query().include("user").order([.descending("createdAt")])
        query.find { [weak self] result in
            switch result {
            case .success(let posts):
                self?.posts = posts
                self?.tableView.reloadData()
                self?.tableView.refreshControl?.endRefreshing()
            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }
        }
    }
    
    func showAlert(description: String) {
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
