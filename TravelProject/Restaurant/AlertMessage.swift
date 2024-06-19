//
//  AlertMassege.swift
//  TravelProject
//
//  Created by dopamint on 6/20/24.
//

import Foundation

enum LocationServieAlertMessage {
    case servieOff
    case denied
    
    func showMessage() -> String {
        switch self {
        case .servieOff:
            return "위치 서비스를 사용할 수 없습니다.\n기기의 설정에서 위치 서비스를 켜주세요."
        case .denied:
            return "위치 서비스를 사용할 수 없습니다.\n기기의 설정에서 앱의 위치 서비스 사용 권한을 허가 해주세요."
        }
        
    }
}
