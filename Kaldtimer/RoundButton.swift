//
//  RoundButton.swift
//  Kaldtimer
//
//  Created by Kyle Rohr on 12/7/21.
//

import UIKit

class RoundButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
    }

    private func setup() {
        layer.borderWidth = Style.borderWidth
        layer.borderColor = UIColor.label.cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = frame.height / 2
    }

    override func setTitle(_ title: String?, for state: UIControl.State) {
        let attributedString = NSAttributedString(string: title?.uppercased() ?? "", attributes: Style.titleAttributes)
        super.setAttributedTitle(attributedString, for: .normal)
    }

}

extension RoundButton {

    struct Style {
        static let borderWidth: CGFloat = 4
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.label,
            .font: UIFont.preferredFont(forTextStyle: .body)
        ]
    }

}
