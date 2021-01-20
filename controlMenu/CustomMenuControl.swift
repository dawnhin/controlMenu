//
//  CustomMenuControl.swift
//  controlMenu
//
//  Created by 黎铭轩 on 30/12/2020.
//

import UIKit

class CustomMenuControl: UIControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        //点击时候展示菜单
        showsMenuAsPrimaryAction=true
        configureBackground(highlighted: false)
    }
    convenience init(frame: CGRect, primaryAction: UIAction?) {
        self.init(frame: frame)
        if let primaryAction = primaryAction {
            addAction(primaryAction, for: .primaryActionTriggered)
            titleLabel.text=primaryAction.title
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureBackground(highlighted: Bool) {
        backgroundColor=highlighted ? .systemGray2 : .systemGray5
        layer.cornerRadius=highlighted ? 8 : 16
        layer.cornerCurve=CALayerCornerCurve.continuous
        self.titleLabel.text="标题"
    }
    func proxyAction(_ action: UIAction, selected: Bool) -> UIAction {
        let proxy=UIAction(title: action.title, image: action.image, discoverabilityTitle: action.discoverabilityTitle, attributes: action.attributes, state: selected ? .on : .off) { (proxy) in
            guard let control=proxy.sender as? CustomMenuControl else {return}
            control.selectedIndex=control.items.firstIndex(of: action) ?? -1
            control.sendAction(action)
            control.sendActions(for: .primaryActionTriggered)
        }
        return proxy
    }
    private lazy var titleLabel: UILabel = {
        let label=UILabel()
        label.textColor=tintColor
        label.highlightedTextColor=UIColor.secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints=false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            heightAnchor.constraint(greaterThanOrEqualTo: label.heightAnchor),
            heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
        return label
    }()
    var menu: UIMenu {
        let selectedAction: UIAction?
        if showSelectedItem && selectedIndex >= 0 && selectedIndex < items.count {
            selectedAction=items[selectedIndex]
        }else{
            selectedAction=nil
        }
        return UIMenu(title: "", children: items.map({
            proxyAction($0, selected: $0 == selectedAction)
        }))
    }
    var items: [UIAction] = [] {
        didSet{
            if items.isEmpty {
                self.contextMenuInteraction?.dismissMenu()
                self.isContextMenuInteractionEnabled=false
            }else{
                self.updateMenuIfVisible()
                self.isContextMenuInteractionEnabled=true
            }
        }
    }
    var showSelectedItem: Bool = true {
        didSet{
            self.updateMenuIfVisible()
        }
    }
    var selectedIndex: Int = -1 {
        didSet{
            self.updateMenuIfVisible()
        }
    }
    //更新菜单
    func updateMenuIfVisible() {
        self.contextMenuInteraction?.updateVisibleMenu({ [unowned self](_) -> UIMenu in
            return self.menu
        })
    }
    func previewForMenuPresentation() -> UITargetedPreview {
        let previewTarget=UIPreviewTarget(container: titleLabel, center: titleLabel.center)
        let previewParameters=UIPreviewParameters()
        previewParameters.backgroundColor=UIColor.clear
        return UITargetedPreview(view: UIView(frame: titleLabel.frame), parameters: previewParameters, target: previewTarget)
    }
    func animateBackgroundHighlight(_ animator: UIContextMenuInteractionAnimating?, highlighted: Bool) {
        if let animator = animator {
            animator.addAnimations {
                self.configureBackground(highlighted: highlighted)
            }
        }else{
            configureBackground(highlighted: highlighted)
        }
    }
    override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (_) -> UIMenu? in
            self.menu
        }
    }
    override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, previewForHighlightingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return previewForMenuPresentation()
    }
    override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, previewForDismissingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return previewForMenuPresentation()
    }
    override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willDisplayMenuFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        super.contextMenuInteraction(interaction, willDisplayMenuFor: configuration, animator: animator)
        animateBackgroundHighlight(animator, highlighted: true)
    }
    override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willEndFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        super.contextMenuInteraction(interaction, willEndFor: configuration, animator: animator)
        animateBackgroundHighlight(animator, highlighted: false)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
