import UIKit

extension UIView {

    func updateConstraint(attribute: NSLayoutConstraint.Attribute, constant: CGFloat) {
        if let constraint = constraints.first(where: { $0.firstAttribute == attribute }) {
            constraint.constant = constant
        } else {
            if attribute == .height || attribute == .width {
                let newConstraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: nil, attribute:attribute, multiplier: 1, constant: constant)
                addConstraint(newConstraint)
            }
        }
        layoutIfNeeded()
    }
}
