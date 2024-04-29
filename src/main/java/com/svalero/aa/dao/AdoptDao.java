package com.svalero.aa.dao;
import com.svalero.aa.domain.Adoption;
import com.svalero.aa.domain.Favorite;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;
import java.util.List;

public interface AdoptDao {

    @SqlQuery("SELECT * FROM adoptions")
    @UseRowMapper(AdoptMapper.class)
    List<Adoption> getAllAdoptions();

    @SqlQuery("SELECT * FROM adoptions WHERE user_id = ?")
    @UseRowMapper(AdoptMapper.class)
    Adoption getAdoptionByUser(int user_id);

    @SqlQuery("SELECT * FROM adoptions WHERE dog_id = ?")
    @UseRowMapper(AdoptMapper.class)
    Adoption getAdoptionByDog(int dog_id);

    @SqlUpdate("DELETE FROM adoptions WHERE dog_id = ?")
    int removeAdoption(int dog_id);

    @SqlUpdate("INSERT INTO adoptions (dog_id, user_id) VALUES (?, ?)")
    int adoptDog(int dog_id, int user_id);

}
