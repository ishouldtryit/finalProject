package com.kh.synergyZone.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.BookmarkDto;
import com.kh.synergyZone.vo.BookmarkVO;

@Repository
public class BookmarkRepoImpl implements BookmarkRepo {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public void addToMyList(BookmarkDto bookmark) {
        sqlSession.insert("bookmark.addToBookmark", bookmark);
    }

    @Override
    public void removeFromBookmark(String bookmarkNo) {
        sqlSession.delete("bookmark.removeFromBookmark", bookmarkNo);
    }

    @Override
    public List<BookmarkDto> getMyList(String ownerNo) {
        return sqlSession.selectList("bookmark.getMyList", ownerNo);
    }

    @Override
    public boolean existsBookmark(String ownerNo, String bookmarkNo) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("ownerNo", ownerNo);
        paramMap.put("bookmarkNo", bookmarkNo);

        int count = sqlSession.selectOne("bookmark.existsBookmark", paramMap);
        return count > 0;
    }

    @Override
    public int checkOwnerCount(String ownerNo) {
        return sqlSession.selectOne("bookmark.checkOwnerCount", ownerNo);
    }
    
    @Override
    public int countMyList(String ownerNo) {
        return sqlSession.selectOne("bookmark.countMyList", ownerNo);
    }
    
    @Override
    public int getOwnerBookmarkCount(String ownerNo, String column, String keyword) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("ownerNo", ownerNo);
        paramMap.put("column", column);
        paramMap.put("keyword", keyword);
        
        return sqlSession.selectOne("bookmark.getOwnerBookmarkCount", paramMap);
    }
}
