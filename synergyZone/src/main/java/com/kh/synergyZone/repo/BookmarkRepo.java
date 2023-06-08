package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.BookmarkDto;

public interface BookmarkRepo {
    void addToMyList(BookmarkDto bookmark);
    void removeFromBookmark(String bookmarkNo);
    List<BookmarkDto> getMyList(String ownerNo);
    boolean existsBookmark(String ownerNo, String bookmarkNo);
    int checkOwnerCount(String ownerNo);
    int countMyList(String ownerNo); 
    int getOwnerBookmarkCount(String ownerNo, String column, String keyword); 
}
