//
//  ViewController.swift
//  musicPlayer
//
//  Created by Mohan K on 05/01/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var getStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStart.layer.cornerRadius = 16
    }


}
//
//#if DEBUG
//import SwiftUI
//
//@available(iOS 13, *)
//struct InfoVCPreview: PreviewProvider {
//    
////    static var devices = ["iPhone 11"]
//    
//    static var previews: some View {
//        // view controller using programmatic UI
//        
//        ViewController().toPreview().previewDevice(PreviewDevice(rawValue: "iPhone 14"))
//            .previewDisplayName("iPhone 14")
////        
////        ViewController().toPreview().previewDevice(PreviewDevice(rawValue: "iPhone SE"))
////            .previewDisplayName("iPhone SE")
//        
////        ForEach(devices, id: \.self) { deviceName in
////            .previewDevice(PreviewDevice(rawValue: deviceName))
////            .previewDisplayName(deviceName)
////        }
//    }
//}
//#endif
