package com.java501.S20230401.dao;

import com.java501.S20230401.model.Favorite;
import com.java501.S20230401.model.Article;

public interface FavoriteDao {
	//김찬영
	int cyFavorite(Favorite favorite);

	// 양동균
	int shareFavoriteAdd(Article article);	// 찜목록 추가
	int shareFavoriteDel(Article article);	// 찜 삭제
	int dgUserFavorite(Article shareUser);	// 찜목록 조회

	//김진현
	void       JHfavoriteInsert2(Article article);
	int        JHfavoriteInsertYN2(Article article);

}
