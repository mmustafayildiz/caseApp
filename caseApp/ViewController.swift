import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
                label.text = "Hello World"
                label.textColor = .blue
                label.textAlignment = .center
                label.frame = CGRect(x: 22, y: 0, width: 330, height: 21)
                label.center = self.view.center
                self.view.addSubview(label)
            }
        }

