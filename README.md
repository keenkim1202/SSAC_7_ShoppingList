# SSAC_7_ShoppingList
쇼핑 목록 리스트를 보여주는 앱입니다. 커스텀 테이블뷰 셀을 활용하는 예제입니다.

# 기능명세 (10/13)
- [x] custom tableViewCell을 활용합니다.
- [x] 셀 디자인으 자유이지만, 체크박스버튼, 컨텐츠 레이블, 즐겨찾기버튼은 필수 입니다.
- [x] String 배열을 선언해 쇼핑 목록을 구성합니다.
- [x] textField의 텍스트를 입력하면 cell이 추가됩니다.
- [x] tableViewCell을 스와이프하여 삭제하면 데이터를 삭제할 수 있습니다.

# 기능명세 (10/14)
- [x] 쇼핑리스트 목록, 구매 여부(체크박스), 즐겨찾기 3가지 정보르 구조체로 구성합니다.
- [x] 구조체 배열을 통해 테이블뷰에 목록을 보여주게 되며, 목록이 추가/삭제 될 때마다 UserDefaluts에 저장됩니다.
- [x] 구매여부, 즐겨찾기 기능 구현은 자유입니다.

# 추가 구현 사항 
- [x] 쇼핑 목록이 없을 시, '쇼핑 리스트가 비어있어요!' 문구 출력
- [x] 체크박스르 체크하면 cell의 색을 초록색으로 변경 
- [x] feature/useUserDefaults 브랜치에 userDefaults르 사용하여 데이터를 저장 
- [x] feature/useRealm 브랜치에 realm을 사용하여 데이터를 저장 

# 더 추가하면 어떨까?
- 즐겨찾기, 구매 전, 구매 완료ㄹ section 별ㄹ 나누어 보여주기
- 모두 구매를 완료하면 축하 문구 띄우기

|참조 이미지||구현 앱 UI|
|:---:|:---:|:--:|
|<img width="100%" src="https://user-images.githubusercontent.com/59866819/137284021-c1b79fac-c50a-4154-8dc8-d11b33adde24.png" />|<img width="120" src="https://user-images.githubusercontent.com/59866819/135194858-4405d3a0-0de3-4ca6-a594-3b08e0ae951b.png" />|<img width="60%" src="https://user-images.githubusercontent.com/59866819/137284035-a0895144-599f-468b-b65d-7348f55fae80.png" />
# 실행 영상
<p align="center"><img width="30%" src="https://user-images.githubusercontent.com/59866819/137284039-432e22a6-05ff-403c-80b1-b557f72a0b7b.mp4" /></p>
