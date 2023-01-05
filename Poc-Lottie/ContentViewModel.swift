//
//  ContentViewModel.swift
//  Poc-Lottie
//
//  Created by DOUARD David on 04/01/2023.
//

import Foundation
import SwiftUI
import DeltaDoreDesignSystem
import Lottie

class ContentViewModel: ObservableObject {
    
    @Published var listModelArray: [DDSListViewModel] = []
    @Published var buttonModel: DDSButtonModel!
    @Published var useLottie: Bool = false {
        didSet {
            buttonModel.variant = useLottie ? .primary : .secondary
            buttonModel.title = useLottie ? "using lottie" : "using images"
            refreshCells()
        }
    }
    let listOfAnimations = ["open_detect_anim_V2", "anim_boost_tablet", "anim-play-icon", "anim-routine-error", "anim-routine-success", "boost_anim_V2", "calibrage_anim_V2", "lock_anim" ]
    
    
    required init() {
        buttonModel = DDSButtonModel(title: useLottie ? "using lottie" : "using images",
                                     variant: .primary,
                                     theme: .light, actionBlock: {[weak self] in
            self?.useLottie.toggle()
        })
        
        refreshCells()
    }
    
    func refreshCells() {
        listModelArray.removeAll()
        let nbCells = 100
        for cellIndex in 0...nbCells {
            let animName = listOfAnimations.randomElement()!
            let settingList = DDSListViewModel(title: "Cellule \(cellIndex)/\(nbCells)",
                                               leftImage: useLottie ? getAnimationSnapShot(name: animName) : Image("couple_yellow_icon") ,
                                               theme: .dark,
                                               rightContentMode: .disclosure,
                                               actionTag: useLottie ? listOfAnimations.randomElement()! : nil)
            
            listModelArray.append(settingList)
        }
    }
    
    func getAnimationSnapShot(name: String, size: CGSize = CGSize(width: 200, height: 200), progressPercent: Int? = 50 ) -> Image? {
        let animationView = LottieAnimationView(frame: CGRect(origin: CGPointZero, size: size))
        animationView.animation = LottieAnimation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.stop()
        animationView.shouldRasterizeWhenIdle = true
        let image = animationView.snapshot(size: size)
        return image.suImage
    }
}

extension UIView {
    func snapshot(size: CGSize?) -> UIImage {
        let targetSize = size ?? self.intrinsicContentSize
        self.bounds = CGRect(origin: CGPoint(x: 0, y: 0), size: targetSize)
        self.backgroundColor = .clear
        
        let format = UIGraphicsImageRendererFormat()
        format.scale = 3 // Ensures 3x-scale images. You can customise this however you like.
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
        return renderer.image { _ in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
    }
}

struct LottieView: UIViewRepresentable {
    var name: String
    var loopMode: LottieLoopMode = .loop
    var animationView = LottieAnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        animationView.animation = LottieAnimation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.stop()
        animationView.shouldRasterizeWhenIdle = true
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {}
}

extension View {
    func snapshot() -> UIImage? {
        // Must ignore safe area due to a bug in iOS 15+ https://stackoverflow.com/a/69819567/1011161
        let controller = UIHostingController(rootView: self.edgesIgnoringSafeArea(.top))
        let view = controller.view
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: CGPoint(x: 0, y: 0), size: targetSize)
        view?.backgroundColor = .clear
        
        let format = UIGraphicsImageRendererFormat()
        format.scale = 3 // Ensures 3x-scale images. You can customise this however you like.
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}


