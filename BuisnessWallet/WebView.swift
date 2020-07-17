import UIKit
import WebKit

class WebView: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var type: Int = -1
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch type {
        case 0:
            navigationItem.title = "Imprint"
            webView.load(URLRequest(url: URL(string: "https://www.google.de")!))
        case 1:
            navigationItem.title = "Licenses"
            webView.load(URLRequest(url: URL(string: "https://www.google.de")!))
        default:
            fatalError("")
        }
    }
    
}
