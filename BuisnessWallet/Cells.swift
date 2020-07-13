import UIKit

class TextCell: UITableViewCell {
    static let identifier = "textCell"
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var textfield: UITextField!
}

class ImageCell: UITableViewCell {
    static let identifier = "imageCell"
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var iconView: UIImageView!
}

class ColorCell: UITableViewCell {
    static let identifier = "colorCell"
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var colorView: UIView!
}

class ButtonCell: UITableViewCell {
    static let identifier = "buttonCell"
    @IBOutlet weak var label: UILabel!
}

