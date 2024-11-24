class FeedViewController: UIViewController {
    
    @IBAction func onLogoutTapped(_ sender: UIButton) {
        User.logout { result in
            switch result {
            case .success:
                print("✅ Successfully logged out")
                // Navigate back to login screen
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                self.navigationController?.pushViewController(loginVC!, animated: true)
            case .failure(let error):
                print("❌ Error logging out: \(error.localizedDescription)")
            }
        }
    }
}
