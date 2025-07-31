//
//  APIKey.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/31/25.
//

import Foundation

enum APIKey {
  static var kakao: String {
    // url에 PrivateKey 파일의 경로를 URL 타입으로 반환
    guard let url = Bundle.main.url(forResource: "PrivateKey", withExtension: "plist"),
          // 파일 내부 내용을 딕셔너리로 읽음 -> [Key:Value] 형식으로
          let dict = NSDictionary(contentsOf: url),
          // "KAKAO_API_KEY"의 값을 찾아서 String으로 바인딩
          let key = dict["KAKAO_API_KEY"] as? String else {
      fatalError("KAKAO_API_KEY가 안보입니다")
    }
    return key
  }
}
