//
//  SLPasswordField.swift
//  SwiftLightning
//
//  Created by Howard Lee on 2018-04-17.
//  Copyright © 2018 BiscottiGelato. All rights reserved.
//

import UIKit

@IBDesignable class SLPasswordField: NibView {

  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var underlineView: UIView!
  @IBOutlet weak var infoLabel: UILabel!
  @IBOutlet weak var unhideButton: UIButton!
  
  @IBOutlet weak var fieldLineConstraint: NSLayoutConstraint!
  @IBOutlet weak var underlineHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var lineLabelContraint: NSLayoutConstraint!
  
  override var intrinsicContentSize: CGSize {
    let height = textField.intrinsicContentSize.height +
                 fieldLineConstraint.constant +
                 underlineHeightConstraint.constant +
                 lineLabelContraint.constant +
                 infoLabel.intrinsicContentSize.height
    
    SCLog.verbose("Intrinsic Content Width \(288.0), Height \(height)")
    
    return CGSize(width: 288.0, height: height)
  }
}
