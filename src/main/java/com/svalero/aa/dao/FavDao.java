package com.svalero.aa.dao;
import com.svalero.aa.domain.Favorite;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;
import java.util.List;

public interface FavDao {

    @SqlQuery("SELECT * FROM favorites")
    @UseRowMapper(FavMapper.class)
    List<Favorite> getAllFavorites();

    @SqlQuery("SELECT * FROM favorites WHERE dog_id = ? AND user_id = ?")
    @UseRowMapper(FavMapper.class)
    Favorite getFavorite(int dog_id, int user_id);


    @SqlQuery("SELECT * FROM favorites WHERE user_id = ?")
    @UseRowMapper(FavMapper.class)
    List<Favorite> getFavoriteByUser(int user_id);


    @SqlQuery("SELECT COUNT(*) FROM favorites WHERE dog_id = ?")
    int getFavCount(int dog_id);

    @SqlUpdate("INSERT INTO favorites(dog_id, user_id) VALUES (?, ?)")
    int addFav(int dog_id, int user_id);

    @SqlUpdate("DELETE FROM favorites WHERE fav_id = ?")
    int removeFavorite(int fav_id);

    @SqlUpdate("DELETE FROM favorites WHERE dog_id = ?")
    int removeFavoritebyDog(int dog_id);

    @SqlUpdate("DELETE FROM favorites WHERE user_id = ?")
    int removeFavbyuser(int user_id);

}
