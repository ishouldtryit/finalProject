package com.kh.synergyZone.vo;

import lombok.Data;

@Data
public class PaginationVO {

  private String column = "";
  private String keyword = "";
  
  // 현재 페이지
  private int page = 1;
  
  // 페이지 마다 보여줄 게시글 수
  private int size = 15;
  
  // 전체 게시글 개수
  private int count;
  
  // 블럭마다 보여줄 숫자 개수
  private int blockSize = 5;

  // 페이지 검색 형태
  private String pageStatus;
  
  // 긴급 문서 우선 조회
  private boolean isemergency;
  
  // 정렬 항목
  private String item = "allboard_no";
  
  // 오름차순 내림차순
  private String order = "desc";
  
  // 특수조건
  private String special = "";

  // 검색 여부 판단
  public boolean isSearch() {
    return !keyword.equals("");
  }

  public boolean isList() {
    return !isSearch();
  }

  // 태그 검색을 위한 문자열 입력
  public String tagList = "";

  // 태그 검색용 파라미터 자동 생성
  public String getTagParameter() {
    StringBuilder buffer = new StringBuilder();
    buffer.append("size=");
    buffer.append(size);
    buffer.append("&tagList=");
    buffer.append(tagList);
    buffer.append("&column=");
    buffer.append(column);
    buffer.append("&keyword=");
    buffer.append(keyword);
    return buffer.toString();
  }

  // 파라미터 자동 생성
  public String getParameter() {
    StringBuilder buffer = new StringBuilder();
    buffer.append("size=");
    buffer.append(size);
    if (isSearch()) {
      buffer.append("&column=");
      buffer.append(column);
      buffer.append("&keyword=");
      buffer.append(keyword);
    } else {	
      buffer.append("&column=&keyword=");
    }
    return buffer.toString();
  }

  public String getAddParameter() {
    StringBuilder buffer = new StringBuilder();
    buffer.append("&item=");
    buffer.append(item);
    buffer.append("&order=");
    buffer.append(order);
    buffer.append("&special=");
    buffer.append(special);
    return buffer.toString();
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
  
  // 정렬 항목
  private String sort = "member_regdate desc";

  // sort 정의 
  public String getSort() {
    return sort;
  }

  public void setSort(String sort) {
    this.sort = sort;
  }
  
  // 쿼리스트링(column + keyword) 생성
  public String getQueryString() {
    return this.keyword.equals("") ? "" : "&column=" + this.column + "&keyword=" + this.keyword;
  }
}
