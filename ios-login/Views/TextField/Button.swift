import UIKit

public enum ButtonStyle: Int {
    case primaryButton = 0
    case secondaryButton = 1
}

@IBDesignable
public class Button: UIButton {
    var buttonStyle: ButtonStyle = .primaryButton {
        didSet {
            commonFormat()
        }
    }

    @IBInspectable
    var buttonStyleSelector: Int = 0 {
       didSet {
        guard let newStyle = ButtonStyle(rawValue: buttonStyleSelector) else {
            buttonStyle = ButtonStyle.primaryButton
            commonFormat()
            return
        }
        buttonStyle = newStyle
        commonFormat()
       }
    }

    override init(frame: CGRect) {
         super.init(frame: frame)
         commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         commonInit()
    }

    override public func prepareForInterfaceBuilder() {
         super.prepareForInterfaceBuilder()
         commonInit()
    }

    private func commonInit() {
        commonFormat()
    }

    private func commonFormat() {
        switch buttonStyle {
        case .primaryButton:
            formatButtonPrimary()
        case .secondaryButton:
            formatButtonSecondary()
        }

        setNeedsLayout()
    }

    fileprivate func setCommonFormats() {
        frame.size.height = 48
        updateConstraint(attribute: .height, constant: frame.size.height)

         layer.masksToBounds = true
         layer.cornerRadius = 4

        titleLabel?.font = .BodySemiBold17
    }

    fileprivate func formatButtonPrimary() {
        setCommonFormats()
        
        setTitleColor(.white, for: .normal)
        setBackgroundColor(.Purple, for: .normal)

        setTitleColor(.white, for: .highlighted)
        setBackgroundColor(.PrimaryButtonPressed, for: .highlighted)

        setTitleColor(.white, for: .disabled)
        setBackgroundColor(.RunwayGray, for: .disabled)

        layer.borderWidth = 0
    }

    fileprivate func formatButtonSecondary() {
        setCommonFormats()

        setTitleColor(.Purple, for: .normal)
        setBackgroundColor(.white, for: .normal)

        setTitleColor(.Purple, for: .highlighted)
        setBackgroundColor(.SecondaryButtonPressed, for: .highlighted)

        setTitleColor(.white, for: .disabled)
        setBackgroundColor(.RunwayGray, for: .disabled)

        if isEnabled {
            layer.borderWidth = 2
            layer.borderColor = UIColor.Purple.cgColor
        } else {
            layer.borderWidth = 0
        }
    }

    override public var isEnabled: Bool {
        didSet {
            commonFormat()
        }
    }
}
