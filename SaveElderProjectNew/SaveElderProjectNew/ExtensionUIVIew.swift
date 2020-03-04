//
//  ExtensionUIVIew.swift
//  SaveElderProjectNew
//
//  Created by 정의석 on 2020/01/16.
//  Copyright © 2020 정의석. All rights reserved.
//

import UIKit
extension UIView {
  func shadow() {
    self.layer.shadowRadius = 5.0
    self.layer.shadowOpacity = 0.3
    self.layer.shadowOffset = .zero
    self.layer.shadowColor = UIColor.darkGray.cgColor
  }
    func addSubviews(_ views: [UIView]) {
    views.forEach { addSubview($0) }
  }
  // MARK: - AutoLayoutAnchor Helper
  var layout: UIView {
    translatesAutoresizingMaskIntoConstraints = false
    return self
  }
    
  @discardableResult // 반환값을 사용하지 않더라도 warning을 나지 않게 해줌
  func top(equalTo anchor: NSLayoutYAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
    let anchor = anchor ?? superview!.safeAreaLayoutGuide.topAnchor
    topAnchor.constraint(equalTo: anchor, constant: c).isActive = true
    return self
  }
    
  @discardableResult
  func leading(equalTo anchor: NSLayoutXAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
    let anchor = anchor ?? superview!.safeAreaLayoutGuide.leadingAnchor
    leadingAnchor.constraint(equalTo: anchor, constant: c).isActive = true
    return self
  }
  @discardableResult
  func bottom(equalTo anchor: NSLayoutYAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
    let anchor = anchor ?? superview!.safeAreaLayoutGuide.bottomAnchor
    bottomAnchor.constraint(equalTo: anchor, constant: c).isActive = true
    return self
  }
  @discardableResult
  func trailing(equalTo anchor: NSLayoutXAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
    let anchor = anchor ?? superview!.safeAreaLayoutGuide.trailingAnchor
    trailingAnchor.constraint(equalTo: anchor, constant: c).isActive = true
    return self
  }
  @discardableResult
  func centerX(equalTo anchor: NSLayoutXAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
    let anchor = anchor ?? superview!.safeAreaLayoutGuide.centerXAnchor
    centerXAnchor.constraint(equalTo: anchor, constant: c).isActive = true
    return self
  }
  @discardableResult
  func centerY(equalTo anchor: NSLayoutYAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
    let anchor = anchor ?? superview!.safeAreaLayoutGuide.centerYAnchor
    centerYAnchor.constraint(equalTo: anchor, constant: c).isActive = true
    return self
  }
}
