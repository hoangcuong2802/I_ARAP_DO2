//
//  String+extension.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/06/15.
//

import UIKit

extension String {
    
    //글자 자르기 위한 함수
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return self
        }
        
        // Index 값 획득
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1) // '+1'이 있는 이유: endIndex는 문자열의 마지막 그 다음을 가리키기 때문
        
        // 파싱
        return String(self[startIndex ..< endIndex])
    }
    
    
    //상태코드 => 문자열
    func toStatus() -> String{
        switch self {
        case "OBJSTT100":
            return "작업대기"
        case "OBJSTT200":
            return "작업중"
        case "OBJSTT300":
            return "중지"
        case "OBJSTT400":
            return "완료"
        default:
            return ""
        }
    }
    
    //상태코드 => 문자열
    func toStatusColor() -> UIColor{
        switch self {
        case "OBJSTT100":
            return .systemGray
        case "OBJSTT200":
            return .systemGreen
        case "OBJSTT300":
            return .systemRed
        case "OBJSTT400":
            return .systemBlue
        default:
            return .white
        }
    }
    
    
    //서버에서 내려준 YYYY-MM-dd HH:mm:ss 형태의 날자값을 "오전 02:25" 이렇게 변형
    func toTime() -> String{
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let date = df.date(from: self) ?? Date()
        df.dateFormat = "a hh:mm"
        df.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        df.locale = Locale(identifier:"ko_KR")
        return df.string(from: date)
    }
}
