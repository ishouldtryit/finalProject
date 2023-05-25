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
        // 중복 체크를 위해 기존에 존재하는 북마크 번호인지 확인
        int count = sqlSession.selectOne("bookmark.checkBookmarkNo", bookmark.getBookmarkNo());
        if (count == 0) {
            sqlSession.insert("bookmark.addToBookmark", bookmark);
        } else {
            // 이미 존재하는 북마크 번호이므로 추가하지 않음
            System.out.println("이미 존재하는 북마크 번호입니다: " + bookmark.getBookmarkNo());
        }
    }

	@Override
	public void removeFromBookmark(String bookmarkNo) {
        sqlSession.delete("bookmark.removeFromBookmark", bookmarkNo);
	}

	@Override
	public List<BookmarkDto> getMyList(String ownerNo) {
	    return sqlSession.selectList("bookmark.getMyList", ownerNo);
	}
}
