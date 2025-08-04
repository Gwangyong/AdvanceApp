# 📚 AdvanceApp

Swift 기반 책 검색 및 최근 본 책 기능을 포함한 iOS 앱입니다. Kakao 책 검색 API를 활용하여 사용자가 관심 있는 책을 검색하고, CoreData를 통해 최근 본 책을 저장 및 관리할 수 있도록 구현되었습니다.

<br/>

## 🧱 아키텍처

- `MVVM` (Model - View - ViewModel) 패턴을 기반으로 구조화
- RxSwift + RxCocoa 를 이용한 Reactive 프로그래밍
- `CoreData`를 이용한 로컬 데이터 저장
- `SnapKit`을 통한 UI 제약조건 설정

<br/>

## ✅ 기능 요약

### 🔍 Step 1: 책 검색 화면 구현
- 사용자는 키워드를 입력해 책을 검색 가능
- 검색 결과는 > `UICollectionViewCompositionalLayout`을 활용한 컬렉션 뷰로 보여집니다.
- 이미지가 없는 경우 `Placeholder` 이미지가 표시됩니다.
- 책 정보를 탭하면 상세 정보 모달로 진입합니다.

### 🗃️ Step 2: 데이터 모델링 및 API 연결
- Kakao Book API 연동
- API 결과를 기반으로 `Document` 모델 구성
- 책 제목, 저자, 가격, 이미지, 설명 등 필요한 정보만 추출

### 💾 Step 3: CoreData 저장 기능
- 담기 버튼을 누르면 해당 책이 CoreData에 저장
- 저장된 책 리스트는 담은 책 탭에서 확인 가능
- 중복 저장 방지, 저장일 기준으로 최신순으로 정렬

### 🕘 Step 4: 최근 본 책 기능 구현
- 상세 페이지를 본 책은 자동으로 최근 본 책 리스트에 추가
- 최대 10개까지 저장되며, 가장 최근에 본 책이 왼쪽에 위치
- 검색 결과 상단에 최근 본 책 섹션이 표시되며, 없을 경우 `hidden` 처리
- CoreData에 중복 저장 방지 및 날짜 기반 정렬 구현
- 최근 본 책 셀을 탭하면 다시 상세 페이지(Modal)로 이동 가능

<br/>

## 🧪 기능 시연 & 화면 대응

| 기능 구현 시연 (iPhone 16 Pro) | 작은 화면 대응 (iPhone SE2) |
|------------------------------|-----------------------------|
| <img src="https://github.com/user-attachments/assets/487dc139-fe35-4f8d-ae7d-50b589c82db0" width="300"/> | <img src="https://github.com/user-attachments/assets/1d65fa7b-ea7b-421f-8a4a-04e65e2e3683" width="300"/> |

> 💡 iPhone 16 Pro 기준으로 기능을 시연하였으며, 작은 화면(iPhone SE2)에서도 UI가 문제없이 대응됩니다.

<br/>

## 🗂️ 프로젝트 구조

```
AdvanceApp
├── App
│   ├── APIKey.swift
│   ├── AppDelegate.swift
│   ├── Info.plist
│   ├── LaunchScreen.storyboard
│   ├── PrivateKey.swift
│   └── SceneDelegate.swift
│
├── Model
│   ├── Book.swift
│   └── BookStatusKey.swift
│
├── Presentation
│   ├── BookDetail
│   │   ├── View
│   │   │   └── BookDetailViewController.swift
│   │   └── ViewModel
│   │       └── BookDetailViewModel.swift
│   │
│   ├── BookSearch
│   │   ├── View
│   │   │   ├── BookSearchViewController.swift
│   │   │   ├── RecentBookCell.swift
│   │   │   ├── RecentBookSectionHeader.swift
│   │   │   ├── SearchResultCell.swift
│   │   │   └── SearchResultSectionHeader.swift
│   │   └── ViewModel
│   │       └── BookSearchViewModel.swift
│   │
│   ├── SavedBooks
│   │   ├── View
│   │   │   ├── SavedBookCell.swift
│   │   │   ├── SavedBooksTopBarView.swift
│   │   │   └── SavedBooksViewController.swift
│   │   └── ViewModel
│   │       └── SavedBooksViewModel.swift
│   │
│   └── Extension
│       ├── BookSearchViewController+Layout.swift
│       ├── Int+FormatPrice.swift
│       ├── UIImageView+URLLoad.swift
│       └── ViewController+UI.swift
│
├── Resource
│   └── Assets.xcassets
│
└── Service
    ├── CoreData
    │   ├── AdvanceApp.xcdatamodeld
    │   ├── BookList+CoreDataClass.swift
    │   ├── BookList+CoreDataProperties.swift
    │   └── CoreDataRepository.swift
    │
    └── BookAPIService.swift
```

## ⚙️ 기술 스택
-   **Swift**
    
-   **MVVM Architecture**
    
-   **RxSwift / RxCocoa (v6.9.0)**
    
-   **Alamofire (v5.10.2)** - 네트워크 통신
    
-   **Kingfisher (v8.5.0)** - 비동기 이미지 로딩 및 캐싱
    
-   **SnapKit (v5.7.1)** - 오토레이아웃 DSL
    
-   **Then (v3.0.0)** - 초기화 코드 간결화
    
-   **CoreData** - 로컬 데이터 영구 저장소
    
-   **Kakao Book API** - 외부 책 검색 API

<br/>

## 📝 참고 사항

- API Key는 별도 `.plist`에 분리하여 관리
- 모든 셀은 재사용 가능한 커스텀 셀로 구성
- ViewModel 내부에서 API 호출 및 데이터 변환 처리
