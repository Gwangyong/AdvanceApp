//
//  BookAPIService.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/30/25.
//

import Alamofire
import RxSwift

class BookAPIService {
  private let url = "https://dapi.kakao.com/v3/search/book"
  private let headers: HTTPHeaders = ["Authorization": "KakaoAK 20e795a49bd7af5fd0a79a4af35f0c89"] // 인증 정보를 담는 헤더
    
  func searchBooks(keyword: String) -> Observable<[Document]> {
    return Observable.create { observer in
      let parameters: Parameters = ["query": keyword] // 검색어
      
      // url + 검색어 + 인증 API
      AF.request(self.url, parameters: parameters, headers: self.headers)
        .responseDecodable(of: Book.self) { response in
          switch response.result {
          case .success(let book):
            observer.onNext(book.documents)
            observer.onCompleted()
          case .failure(let error):
            observer.onError(error)
          }
        }
      
      return Disposables.create()
    }
  }
}
