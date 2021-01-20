//
//  UpdateMenuViewController.swift
//  controlMenu
//
//  Created by 黎铭轩 on 16/1/2021.
//

import UIKit

class UpdateMenuViewController: UIViewController, UIContextMenuInteractionDelegate {

    var contextMenuInteraction: UIContextMenuInteraction!
    func demoImage() -> UIImageView {
        let imageView=UIImageView(image: UIImage(systemName: "shield.fill"))
        imageView.isUserInteractionEnabled=true
        imageView.preferredSymbolConfiguration=UIImage.SymbolConfiguration(pointSize: 288)
        return imageView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor=UIColor.systemBackground
        title="更新菜单"
        let imageView=demoImage()
        contextMenuInteraction=UIContextMenuInteraction(delegate: self)
        imageView.addInteraction(contextMenuInteraction)
        imageView.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        if interaction.menuAppearance == UIContextMenuInteraction.appearance.rich {
            //对于一个富展示，我们将用一个更短的菜单和配置预览
            return UIContextMenuConfiguration(identifier: nil) { () -> UIViewController? in
                let viewController=UIViewController()
                let imageView=self.demoImage()
                viewController.view=imageView
                viewController.preferredContentSize=imageView.sizeThatFits(CGSize.zero)
                return viewController
            } actionProvider: { (_) -> UIMenu? in
                return UIMenu(title: "", children: [
                    UIAction(title: "项目1", image: UIImage(systemName: "mic")) { (_) in
                    },
                    UIAction(title: "项目2", image: UIImage(systemName: "message"), handler: { (_) in
                    }),
                    UIAction(title: "项目3", image: UIImage(systemName: "envelope")) { (_) in
                    },
                    UIAction(title: "项目4", image: UIImage(systemName: "phone"), handler: { (_) in
                    }),
                    UIAction(title: "项目5", image: UIImage(systemName: "video"), handler: { (_) in
                    })
                ])
            }
        }else{
            //对于一个紧凑展示，我们聚焦于菜单，但添加额外动作
            return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (_) -> UIMenu? in
                return UIMenu(title: "", children: [
                    UIAction(title: "项目1", image: UIImage(systemName: "mic")) { (_) in
                    },
                    UIAction(title: "项目2", image: UIImage(systemName: "message"), handler: { (_) in
                    }),
                    UIAction(title: "项目3", image: UIImage(systemName: "envelope")) { (_) in
                    },
                    UIAction(title: "项目4", image: UIImage(systemName: "phone"), handler: { (_) in
                    }),
                    UIAction(title: "项目5", image: UIImage(systemName: "video"), handler: { (_) in
                    }),
                    UIMenu(title: "", options: UIMenu.Options.displayInline, children: [
                        UIAction(title: "紧凑项目1", image: UIImage(systemName: "mic")) { (_) in
                        },
                        UIAction(title: "紧凑项目2", image: UIImage(systemName: "message"), handler: { (_) in
                        }),
                        UIAction(title: "紧凑项目3", image: UIImage(systemName: "envelope")) { (_) in
                        },
                        UIAction(title: "紧凑项目4", image: UIImage(systemName: "phone"), handler: { (_) in
                        }),
                        UIAction(title: "紧凑项目5", image: UIImage(systemName: "video"), handler: { (_) in
                        })
                    ])
                ])
            }
        }
    }
    var timer: Timer?
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willDisplayMenuFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        timer?.invalidate()
        timer=Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { [unowned self](_) in
            self.contextMenuInteraction.updateVisibleMenu { (currentMenu) -> UIMenu in
                currentMenu.children.forEach { (element) in
                    guard let action=element as? UIAction else {return}
                    action.state=Bool.random() ? .off : .on
                    action.attributes=Bool.random() ? [.hidden] : UIMenuElement.Attributes()
                }
                return currentMenu
            }
        })
    }
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willEndFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        timer?.invalidate()
        timer=nil
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
