//
//  KYLTagView.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/22.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit


internal struct Constants {
    internal static let TEXT_FIELD_HSPACE: CGFloat = 6.0
    internal static let MINIMUM_TEXTFIELD_WIDTH: CGFloat = 56.0
    internal static let STANDARD_ROW_HEIGHT: CGFloat = 25.0
}

public struct KYLTag: Hashable {
    
    public let text: String
    public let context: AnyHashable?
    
    public init(_ text: String, context: AnyHashable? = nil) {
        self.text = text
        self.context = context
    }
    
    public func equals(_ other: KYLTag) -> Bool {
        return self.text == other.text && self.context == other.context
    }
}

public func == (lhs: KYLTag, rhs: KYLTag) -> Bool {
    return lhs.equals(rhs)
}


open class KYLTagView: UIView {
    fileprivate let textLabel = UILabel()
    
    open var displayText: String = "" {
        didSet {
            updateLabelText()
            setNeedsDisplay()
        }
    }
    
    open var displayDelimiter: String = "" {
        didSet {
            updateLabelText()
            setNeedsDisplay()
        }
    }
    
    open var font: UIFont? {
        didSet {
            textLabel.font = font
            setNeedsDisplay()
        }
    }
    
    open var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            setNeedsDisplay()
        }
    }
    open var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
            setNeedsDisplay()
        }
    }
    open var borderColor: UIColor? {
        didSet {
            if let borderColor = borderColor {
                self.layer.borderColor = borderColor.cgColor
                setNeedsDisplay()
            }
        }
    }
    
    open override var tintColor: UIColor! {
        didSet { updateContent(animated: false) }
    }
    
    /// Background color to be used for selected state.
    open var selectedColor: UIColor? {
        didSet { updateContent(animated: false) }
    }
    
    open var textColor: UIColor? {
        didSet { updateContent(animated: false) }
    }
    
    open var selectedTextColor: UIColor? {
        didSet { updateContent(animated: false) }
    }
    
    open var keyboardAppearanceType: UIKeyboardAppearance = .default
    
    internal var onDidRequestDelete: ((_ tagView: KYLTagView, _ replacementText: String?) -> Void)?
    internal var onDidRequestSelection: ((_ tagView: KYLTagView) -> Void)?
    internal var onDidInputText: ((_ tagView: KYLTagView, _ text: String) -> Void)?
    
    open var selected: Bool = false {
        didSet {
            if selected && !isFirstResponder {
                _ = becomeFirstResponder()
            } else
                if !selected && isFirstResponder {
                    _ = resignFirstResponder()
            }
            updateContent(animated: true)
        }
    }
    
    public init(tag: KYLTag) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = tintColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        
        textColor = .white
        selectedColor = .gray
        selectedTextColor = .black
        
        textLabel.frame = CGRect(x: layoutMargins.left, y: layoutMargins.top, width: 0, height: 0)
        textLabel.font = font
        textLabel.textColor = .white
        textLabel.backgroundColor = .clear
        addSubview(textLabel)
        
        self.displayText = tag.text
        updateLabelText()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer))
        addGestureRecognizer(tapRecognizer)
        setNeedsLayout()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assert(false, "Not implemented")
    }
    
    fileprivate func updateColors() {
        self.backgroundColor = selected ? selectedColor : tintColor
        textLabel.textColor = selected ? selectedTextColor : textColor
    }
    
    internal func updateContent(animated: Bool) {
        guard animated else {
            updateColors()
            return
        }
        
        UIView.animate(
            withDuration: 0.2,
            animations: { [weak self] in
                self?.updateColors()
                if self?.selected ?? false {
                    self?.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
                }
            },
            completion: { [weak self] _ in
                if self?.selected ?? false {
                    UIView.animate(withDuration: 0.4) { [weak self] in
                        self?.transform = CGAffineTransform.identity
                    }
                }
            }
        )
    }
    
    // MARK: - Size Measurements
    open override var intrinsicContentSize: CGSize {
        let labelIntrinsicSize = textLabel.intrinsicContentSize
        return CGSize(width: labelIntrinsicSize.width + layoutMargins.left + layoutMargins.right,
                      height: labelIntrinsicSize.height + layoutMargins.top + layoutMargins.bottom)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let layoutMarginsHorizontal = layoutMargins.left + layoutMargins.right
        let layoutMarginsVertical = layoutMargins.top + layoutMargins.bottom
        let fittingSize = CGSize(width: size.width - layoutMarginsHorizontal,
                                 height: size.height - layoutMarginsVertical)
        let labelSize = textLabel.sizeThatFits(fittingSize)
        return CGSize(width: labelSize.width + layoutMarginsHorizontal,
                      height: labelSize.height + layoutMarginsVertical)
    }
    
    open func sizeToFit(_ size: CGSize) -> CGSize {
        if intrinsicContentSize.width > size.width {
            return CGSize(width: size.width,
                          height: intrinsicContentSize.height)
        }
        return intrinsicContentSize
    }
    
    // MARK: - Attributed Text
    fileprivate func updateLabelText() {
        // Unselected shows "[displayText]," and selected is "[displayText]"
        textLabel.text = displayText + displayDelimiter
        // Expand Label
        let intrinsicSize = self.intrinsicContentSize
        frame = CGRect(x: 0, y: 0, width: intrinsicSize.width, height: intrinsicSize.height)
    }
    
    // MARK: - Laying out
    open override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = bounds.inset(by: layoutMargins)
        if frame.width == 0 || frame.height == 0 {
            frame.size = self.intrinsicContentSize
        }
    }
    
    // MARK: - First Responder (needed to capture keyboard)
    open override var canBecomeFirstResponder: Bool {
        return true
    }
    
    open override func becomeFirstResponder() -> Bool {
        let didBecomeFirstResponder = super.becomeFirstResponder()
        selected = true
        return didBecomeFirstResponder
    }
    
    open override func resignFirstResponder() -> Bool {
        let didResignFirstResponder = super.resignFirstResponder()
        selected = false
        return didResignFirstResponder
    }
    
    // MARK: - Gesture Recognizers
    @objc func handleTapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        if selected {
            return
        }
        onDidRequestSelection?(self)
    }
    
}

extension KYLTagView: UIKeyInput {
    
    public var hasText: Bool {
        return true
    }
    
    public func insertText(_ text: String) {
        onDidInputText?(self, text)
    }
    
    public func deleteBackward() {
        onDidRequestDelete?(self, nil)
    }
    
}

extension KYLTagView: UITextInputTraits {
    
    // Solves an issue where autocorrect suggestions were being
    // offered when a tag is highlighted.
    public var autocorrectionType: UITextAutocorrectionType {
        return .no
    }
    
    public var keyboardAppearance: UIKeyboardAppearance {
        return keyboardAppearanceType
    }
    
}
