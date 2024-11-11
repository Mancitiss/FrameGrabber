// this is an empty screen for testing purpose, using test.storyboard as its template

import UIKit

@MainActor protocol TestViewControllerDelegate: AnyObject {
}

final class TestViewController: UITableViewController {
    weak var delegate: TestViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
