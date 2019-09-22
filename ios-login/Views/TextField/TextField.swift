import UIKit

@IBDesignable
public class TextField: UITextField {
    @IBInspectable var isError: Bool = false {
        didSet {
            applyFormating()
        }
    }
    
    @IBInspectable var enableButton: Bool = false {
        didSet {
            applyButtonView()
        }
    }
    
    var rightButton: UIButton?
    
    @IBInspectable var rightButtonImage: UIImage? = UIImage(named: "locationPin")
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }
    
    fileprivate func commonInit() {
        frame.size.height = 48
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48)
            ])
        
        borderStyle = .roundedRect
        
        layer.masksToBounds = true
        layer.cornerRadius = 4
        
        addTarget(self, action: #selector(formatEditBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(formatEditEnd), for: .editingDidEnd)
        addTarget(self, action: #selector(formatEditEnd), for: .editingDidEndOnExit)
        
        applyFormating()
        
        let placeholderText = placeholder
        if placeholderText != nil {
            placeholder = placeholderText
        }
        
    }
    
    fileprivate func applyFormating() {
        if !isEnabled {
            applyDisabledFormat()
        } else {
            if isError {
                applyErrorFormat()
            } else if let textCheck = text {
                if textCheck.isEmpty {
                    applyEmptyFormat()
                } else {
                    applyFilledInFormat()
                }
            } else {
                applyFilledInFormat()
            }
        }
        
        setFont()
        
        setNeedsLayout()
    }
    
    override public var isEnabled: Bool {
        didSet {
            applyFormating()
        }
    }
    
    fileprivate func applyStandardFont() {
        font = .Body
        textColor = .NeutralBlack
    }
    
    public override var placeholder: String? {
        didSet {
            if let placeHolderVar = placeholder {
                attributedPlaceholder = NSAttributedString(string: placeHolderVar)
            }
        }
    }
    
    fileprivate func setFont() {
        if !isEnabled {
            font = .BodyItalic
            textColor = .NeutralGray60
        } else {
            font = UIFont.Body
            textColor = .NeutralBlack
        }
    }
    
    fileprivate func applyDisabledFormat() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.NeutralGray20.cgColor
    }
    
    fileprivate func applyErrorFormat() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.Red.cgColor
    }
    
    fileprivate func applyEmptyFormat() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.RunwayGray.cgColor
    }
    
    fileprivate func applyFilledInFormat() {
        applyEmptyFormat()
    }
    
    @objc fileprivate func formatEditBegin() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.Purple.cgColor
        setNeedsLayout()
    }
    
    @objc fileprivate func formatEditEnd() {
        applyFormating()
    }
    
    fileprivate func applyButtonView() {
        if enableButton {
            rightViewMode = .always
            rightView = buildRightView()
        } else {
            rightViewMode = .never
            rightView = nil
        }
    }
    
    fileprivate func buildRightView() -> UIView {
        let rtnView = UIView(frame: CGRect(x: 0, y: 8, width: 48, height: 32))
        
        let sepBar = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: rtnView.frame.size.height))
        sepBar.backgroundColor = UIColor.NeutralGray40
        rtnView.addSubview(sepBar)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.center = CGPoint(x: 23, y: 16)
        button.setImage(rightButtonImage, for: .normal)
        rightButton = button
        rtnView.addSubview(button)
        
        return rtnView
    }
}
