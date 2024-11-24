import ParseSwift

struct Post: ParseObject {
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?
    
    var caption: String?
    var imageFile: ParseFile?
    var user: User?
}

class PostViewController: UIViewController {
    
    var pickedImage: UIImage?
    @IBOutlet weak var captionTextField: UITextField!
    
    @IBAction func onShareTapped(_ sender: UIButton) {
        guard let image = pickedImage,
              let imageData = image.jpegData(compressionQuality: 0.1) else {
            return
        }
        
        let imageFile = ParseFile(name: "image.jpg", data: imageData)
        
        var post = Post()
        post.imageFile = imageFile
        post.caption = captionTextField.text
        post.user = User.current
        
        post.save { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let post):
                    print("✅ Post saved: \(post)")
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    self.showAlert(description: error.localizedDescription)
                }
            }
        }
    }
    
    func showAlert(description: String) {
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
