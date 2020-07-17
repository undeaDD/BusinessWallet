import UIKit
import PassKit
import MessageUI
import StoreKit

class StartView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var editPhoto: (UIImage?, String)?
    
    #warning("missing localisations")
    #warning("missing url parameters & wrong tableviewcell -> image to color")
    #warning("format date from server")
    #warning("implement description on server side and add to url parameter")
    #warning("app icon missing")
    #warning("license and imprint html files missing")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Business Wallet"
        navigationItem.backButtonTitle = "Back"
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as? WebView
        dest?.type = sender as? Int ?? -1
    }
    
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Rate Business Wallet", style: .default, handler: { _ in
            if let scene = UIApplication.shared.connectedScenes.filter({ $0.activationState == .foregroundActive }).first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }))
        sheet.addAction(UIAlertAction(title: "Send Feedback", style: .default, handler: { _ in
            self.sendMail()
        }))
        sheet.addAction(UIAlertAction(title: "Read Imprint", style: .default, handler: { _ in
            self.performSegue(withIdentifier: "webView", sender: 0)
        }))
        sheet.addAction(UIAlertAction(title: "Show Licenses", style: .default, handler: { _ in
            self.performSegue(withIdentifier: "webView", sender: 1)
        }))
        sheet.addAction(UIAlertAction(title: NSLocalizedString("ButtonCancel", comment: ""), style: .cancel, handler: nil))
        present(sheet, animated: true)
    }

}

extension StartView: MFMailComposeViewControllerDelegate {

    func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["dominic.drees@live.de"])
            mail.setSubject("Business Wallet Feedback")
            present(mail, animated: true)
        } else {
            let alertView = UIAlertController(title: "cant send mail", message: "this device has no mail account.", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: NSLocalizedString("ButtonOkay", comment: ""), style: .cancel, handler: nil))
            present(alertView, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

}

extension StartView: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 8 : 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 5), (0, 6):
            return tableView.dequeueReusableCell(withIdentifier: ImageCell.identifier, for: indexPath)
        case (0, 7):
            return tableView.dequeueReusableCell(withIdentifier: ColorCell.identifier, for: indexPath)
        case (0, _):
            return tableView.dequeueReusableCell(withIdentifier: TextCell.identifier, for: indexPath)
        case (1, _):
            return tableView.dequeueReusableCell(withIdentifier: ButtonCell.identifier, for: indexPath)
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let cell = cell as? TextCell
            cell?.icon.image = UIImage(named: UIImageKeys.fullName.rawValue)
            cell?.textfield.placeholder = NSLocalizedString("PlaceholderFullName", comment: "")
            cell?.textfield.tag = 0
            cell?.textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            cell?.textfield.text = UserDefaults.standard.string(forKey: UserDefaultKeys.fullName.rawValue)
        case (0, 1):
            let cell = cell as? TextCell
            cell?.icon.image = UIImage(named: UIImageKeys.telephone.rawValue)
            cell?.textfield.placeholder = NSLocalizedString("PlaceholderTelephone", comment: "")
            cell?.textfield.tag = 1
            cell?.textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            cell?.textfield.text = UserDefaults.standard.string(forKey: UserDefaultKeys.telephone.rawValue)
        case (0, 2):
            let cell = cell as? TextCell
            cell?.icon.image = UIImage(named: UIImageKeys.emailAddress.rawValue)
            cell?.textfield.placeholder = NSLocalizedString("PlaceholderEmailAddress", comment: "")
            cell?.textfield.tag = 2
            cell?.textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            cell?.textfield.text = UserDefaults.standard.string(forKey: UserDefaultKeys.emailAddress.rawValue)
        case (0, 3):
            let cell = cell as? TextCell
            cell?.icon.image = UIImage(named: UIImageKeys.birthday.rawValue)
            cell?.textfield.placeholder = NSLocalizedString("PlaceholderBirthday", comment: "")
            cell?.textfield.tag = 3
            cell?.textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            cell?.textfield.text = UserDefaults.standard.string(forKey: UserDefaultKeys.birthday.rawValue)
        case (0, 4):
            let cell = cell as? TextCell
            cell?.icon.image = UIImage(named: UIImageKeys.description.rawValue)
            cell?.textfield.placeholder = NSLocalizedString("PlaceholderDescription", comment: "")
            cell?.textfield.tag = 4
            cell?.textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            cell?.textfield.text = UserDefaults.standard.string(forKey: UserDefaultKeys.description.rawValue)
        case (0, 5):
            let cell = cell as? ImageCell
            cell?.icon.image = UIImage(named: UIImageKeys.avatarImage.rawValue)
            cell?.label.text = NSLocalizedString("PlaceholderAvatarImage", comment: "")
            cell?.iconView.image = UserDefaults.standard.image(forKey: UserDefaultKeys.avatarImage.rawValue)
        case (0, 6):
            let cell = cell as? ImageCell
            cell?.icon.image = UIImage(named: UIImageKeys.backgroundImage.rawValue)
            cell?.label.text = NSLocalizedString("PlaceholderBackgroundImage", comment: "")
            cell?.iconView.image = UserDefaults.standard.image(forKey: UserDefaultKeys.backgroundImage.rawValue)
        case (0, 7):
            let cell = cell as? ColorCell
            cell?.icon.image = UIImage(named: UIImageKeys.backgroundColor.rawValue)
            cell?.label.text = NSLocalizedString("PlaceholderBackgroundColor", comment: "")
            cell?.colorView.backgroundColor = UserDefaults.standard.color(forKey: UserDefaultKeys.backgroundColor.rawValue)
        case (1, _):
            let cell = cell as? ButtonCell
            cell?.label.text = NSLocalizedString("ButtonText", comment: "")
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 5):
            let cell = tableView.cellForRow(at: indexPath) as? ImageCell
            changeImage(cell?.iconView.image, UIImageKeys.avatarImage.rawValue)
        case (0, 6):
            let cell = tableView.cellForRow(at: indexPath) as? ImageCell
            changeImage(cell?.iconView.image, UIImageKeys.backgroundImage.rawValue)
        case (0, 7):
            let cell = tableView.cellForRow(at: indexPath) as? ColorCell
            changeColor(cell!.colorView.backgroundColor!)
        case (0, _):
            let cell = tableView.cellForRow(at: indexPath) as? TextCell
            cell?.textfield.becomeFirstResponder()
        case (1, _):
            let cell = tableView.cellForRow(at: indexPath) as? ButtonCell
            cell?.label.isHidden = true
            cell?.indicator.isHidden = false
            exportPass(cell)
        default:
            fatalError()
        }
    }
    
    @objc
    func textFieldDidChange(_ sender: UITextField) {
        switch sender.tag {
        case 0:
            UserDefaults.standard.set(sender.text, forKey: UserDefaultKeys.fullName.rawValue)
        case 1:
            UserDefaults.standard.set(sender.text, forKey: UserDefaultKeys.telephone.rawValue)
        case 2:
            UserDefaults.standard.set(sender.text, forKey: UserDefaultKeys.emailAddress.rawValue)
        case 3:
            UserDefaults.standard.set(sender.text, forKey: UserDefaultKeys.birthday.rawValue)
        case 4:
            UserDefaults.standard.set(sender.text, forKey: UserDefaultKeys.description.rawValue)
        default:
            fatalError()
        }
    }
    
}

extension StartView: UIColorPickerViewControllerDelegate {

    func changeColor(_ currentColor: UIColor) {
        let colorView = UIColorPickerViewController()
        colorView.selectedColor = currentColor
        colorView.delegate = self
        colorView.title = ""
        present(colorView, animated: true)
    }

    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        UserDefaults.standard.set(viewController.selectedColor, forKey: UserDefaultKeys.backgroundColor.rawValue)
    }

    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        viewController.dismiss(animated: true)
        tableView.reloadRows(at: [IndexPath(row: 7, section: 0)], with: .none)
    }

}

extension StartView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {    
    
    func changeImage(_ currentImage: UIImage?, _ key: String) {
        editPhoto = (currentImage, key)
                
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: NSLocalizedString("ButtonPhoto", comment: ""), style: .default, handler: { _ in
            let cameraView = UIImagePickerController()
            cameraView.sourceType = .camera
            cameraView.cameraDevice = .front
            cameraView.allowsEditing = true
            cameraView.delegate = self
            self.present(cameraView, animated: true)
        }))
        sheet.addAction(UIAlertAction(title: NSLocalizedString("ButtonLibrary", comment: ""), style: .default, handler: { _ in
            let cameraView = UIImagePickerController()
            cameraView.sourceType = .photoLibrary
            cameraView.allowsEditing = true
            cameraView.delegate = self
            self.present(cameraView, animated: true)
        }))
        sheet.addAction(UIAlertAction(title: NSLocalizedString("ButtonRemove", comment: ""), style: .destructive, handler: { _ in
            UserDefaults.standard.removeObject(forKey: self.editPhoto!.1)
            self.tableView.reloadRows(at: [IndexPath(row: 5, section: 0), IndexPath(row: 6, section: 0)], with: .none)
        }))
        sheet.addAction(UIAlertAction(title: NSLocalizedString("ButtonCancel", comment: ""), style: .cancel, handler: nil))
        present(sheet, animated: true)
    }
     
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let photo: UIImage = info[.editedImage] as? UIImage ?? info[.originalImage] as! UIImage
        UserDefaults.standard.set(photo, forKey: editPhoto!.1)
        picker.dismiss(animated: true) {
            self.tableView.reloadRows(at: [IndexPath(row: 5, section: 0), IndexPath(row: 6, section: 0)], with: .none)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.tableView.reloadRows(at: [IndexPath(row: 5, section: 0), IndexPath(row: 6, section: 0)], with: .none)
        }
    }
    
}

extension StartView: PKAddPassesViewControllerDelegate {
    
    func exportPass(_ cell: ButtonCell?) {
        if PKPassLibrary.isPassLibraryAvailable() {
            
            let name = UserDefaults.standard.string(forKey: UserDefaultKeys.fullName.rawValue)?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "-"
            let phone = UserDefaults.standard.string(forKey: UserDefaultKeys.telephone.rawValue)?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "-"
            let mail = UserDefaults.standard.string(forKey: UserDefaultKeys.emailAddress.rawValue)?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "-"
            let birthday = UserDefaults.standard.string(forKey: UserDefaultKeys.birthday.rawValue)?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "-"
            
            let url = URL(string: "https://us-central1-ds-deltasiege.cloudfunctions.net/app/pass?name=\(name)&phone=\(phone)&mail=\(mail)&birthday=\(birthday)&foregroundColor=rgb(210,210,210)&backgroundColor=rgb(40,40,40)&labelColor=rgb(250,250,250)")!
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    guard error == nil,
                          let data = data,
                          let pass = try? PKPass(data: data),
                          let passView = PKAddPassesViewController(pass: pass)
                          else {
                        let alertView = UIAlertController(title: NSLocalizedString("TempErrorTitle", comment: ""), message: NSLocalizedString("TempErrorBody", comment: ""), preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: NSLocalizedString("ButtonOkay", comment: ""), style: .cancel, handler: nil))
                        self.present(alertView, animated: true)
                        cell?.label.isHidden = false
                        cell?.indicator.isHidden = true
                        return
                    }

                    passView.delegate = self
                    self.present(passView, animated: true)
                    cell?.label.isHidden = false
                    cell?.indicator.isHidden = true
                }
            }).resume()
        }
    }

    func addPassesViewControllerDidFinish(_ controller: PKAddPassesViewController) {
        controller.dismiss(animated: true)
    }

}
