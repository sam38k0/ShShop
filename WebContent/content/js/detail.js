
$('.accordion').on('click', '.accordion-control', function(e){ // 클릭 이벤트
  e.preventDefault();                    // 버튼의 기본 동작을 취소한다.
  $(this)                                // 사용자가 클릭한 요소를 찾는다.
    .next('.accordion-panel')            // 관련된 패널을 찾는다.
    .not(':animated')                    // 애니메이션이 진행중이지 않으면
    .slideToggle();                      // 패널을 슬라이드 토글한다.
});