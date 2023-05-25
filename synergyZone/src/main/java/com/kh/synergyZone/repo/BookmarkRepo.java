package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.BookmarkDto;
import com.kh.synergyZone.vo.BookmarkVO;

public interface BookmarkRepo {
    void addToMyList(BookmarkDto bookmark);
	void removeFromBookmark(String bookmarkNo);
	List<BookmarkDto> getMyList(String ownerNo);
}
