//
//  Helper.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 27/1/22.
//

import Foundation
import UIKit

struct Helper {
    
    static func apiBaseUrl()->String{
        let env : String = Bundle.main.infoDictionary!["API_BASE_URL"] as! String
        return env
    }
    
//    static func getLottosSession() -> [Lottos]? {
//        let data = LHSettings.current.defaults.value(forKey: "lottosData") as? Data
//
//        if data != nil {
//            let USER = try? PropertyListDecoder().decode([Lottos].self, from: data!)
//            return USER!
//        } else {
//            return nil
//        }
//    }
//
//    static func setUserSession(_ model: [Lottos]) {
//        LHSettings.current.defaults.set(try? PropertyListEncoder().encode(model), forKey: "lottosData")
//    }
    
}
