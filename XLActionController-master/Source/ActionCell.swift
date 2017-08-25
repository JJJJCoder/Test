

import UIKit

public protocol SeparatorCellType: NSObjectProtocol {
    func showSeparator()
    func hideSeparator()
}

open class ActionCell: UICollectionViewCell, SeparatorCellType {

    @IBOutlet open weak var actionTitleLabel: UILabel?
    @IBOutlet open weak var actionImageView: UIImageView?
    @IBOutlet open weak var actionDetailLabel: UILabel?
    @IBOutlet open weak var separatorView: UIView?
    @IBOutlet open weak var imageViewWidthConstraint: NSLayoutConstraint?

    var imageWidth: CGFloat = 0

    open override func awakeFromNib() {
        super.awakeFromNib()

        imageWidth = imageViewWidthConstraint?.constant ?? 0
    }

    open func setup(_ title: String?, detail: String?, image: UIImage?) {
        actionTitleLabel?.text = title
        actionDetailLabel?.text = detail
        actionImageView?.image = image

        imageViewWidthConstraint?.constant = image == nil ? 0 : imageWidth

        setNeedsLayout()
    }
    
    open func showSeparator() {
        separatorView?.alpha = 1.0
    }
    
    open func hideSeparator() {
        separatorView?.alpha = 0.0
    }
}
