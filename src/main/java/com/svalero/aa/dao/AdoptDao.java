package com.svalero.aa.dao;
import com.svalero.aa.domain.Adoption;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;
import java.util.List;

public interface AdoptDao {

    @SqlQuery("SELECT * FROM adoptions")
    @UseRowMapper(AdoptMapper.class)
    List<Adoption> getAllAdoptions();


    @SqlUpdate("DELETE FROM adoptions WHERE dog_id = ?")
    int removeAdoption(int dog_id);

    @SqlUpdate("INSERT INTO adoptions (dog_id, user_id) VALUES (?, ?)")
    int adoptDog(int dog_id, int user_id);

}
