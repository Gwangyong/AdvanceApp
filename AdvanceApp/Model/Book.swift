//
//  Book.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/30/25.
//

struct Book: Codable {
  let documents: [Document]
}

struct Document: Codable, Hashable {
  let authors: [String]
  let contents: String
  let price: Int
  let thumbnail: String // 이미지 주소 (섬네일)
  let title: String
  let translators: [String] // 번역가인데 나중에 시간나면 추가
}
