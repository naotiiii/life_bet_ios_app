//
//  UIButton+.swift
//  life-bet
//
//  Created by naoto kojima on 2022/02/07.
//

import Foundation
import UIKit

public class UIHighlightButton: UIButton {
    
    public override var isHighlighted: Bool {
        didSet {
            if oldValue != isHighlighted {
                isHighlighted = isHighlighted
            }
        }
    }
}
