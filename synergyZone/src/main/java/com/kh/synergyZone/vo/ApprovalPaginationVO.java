package com.kh.synergyZone.vo;

import lombok.Data;

@Data
public class ApprovalPaginationVO {

  private String column = "draft_title";
  private String keyword = "";
  
  // 현재 페이지
  private int page = 1;
  
  // 페이지 마다 보여줄 게시글 수
  private int size = 10;
  
  // 전체 게시글 개수
  private int count;
  
  // 블럭마다 보여줄 숫자 개수
  private int blockSize = 5;

  // 페이지 검색 형태
  private String pageStatus;
  
  // 긴급 문서 우선 조회
  private boolean isemergency;

  // 로그인 유저
  private String loginUser;
  
  // 검색 여부 판단
  public boolean isSearch() {
    return !keyword.equals("");
  }

  public boolean isList() {
    return !isSearch();
  }


  // 시작행 - 페이지에서 보여주는 게시판 첫글 순서
  public int getBegin() {
    return page * size - size + 1;
  }

  // 종료행 - 페이지에서 보여주는 게시판 마지막글 순서
  public int getEnd() {
    return Math.min(page * size, count);
  }

  // 전체페이지
  public int getTotalPage() {
    return (count + size - 1) / size;
  }

  // 시작 블록 번호(번호판 시작)
  public int getStartBlock() {
    return (page - 1) / blockSize * blockSize + 1;
  }
  
  // 끝 블록 번호(번호판 끝)
  public int getFinishBlock() {
    int value = (page - 1) / blockSize * blockSize + blockSize;
    return Math.min(getTotalPage(), value);
  }
  
  // 보이는 블록 수
  public int getViewBlock() {
	  return getFinishBlock() - getStartBlock()+1;
  }

  // 첫 페이지인가?
  public boolean isFirst() {
    return page == 1;
  }

  // 마지막페이지인가?
  public boolean isLast() {
    return page == getTotalPage();
  }

  // [이전]이 나오는 조건 - 시작블록이 1보다 크면(페이지가 blockSize보다 크면)
  public boolean isPrev() {
    return getStartBlock() > 1;
  }

  // [다음]이 나오는 조건 - 종료블록이 마지막페이지보다 작으면
  public boolean isNext() {
    return getFinishBlock() < getTotalPage();
  }

	//[다음]을 누르면 나올 페이지 번호
	public int getNextPage() {
	 int nextPage = getFinishBlock() + 1;
	 return nextPage > getTotalPage() ? getTotalPage() : nextPage;
	}
	
	//[이전]을 누르면 나올 페이지 번호
	public int getPrevPage() {
	 int prevPage = getStartBlock() - 1;
	 return prevPage < 1 ? 1 : prevPage;
	}
  
}
