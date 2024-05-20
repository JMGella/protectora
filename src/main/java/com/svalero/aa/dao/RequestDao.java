package com.svalero.aa.dao;
import com.svalero.aa.domain.Request;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;

public interface RequestDao {
    @SqlQuery("SELECT * FROM requests")
    @UseRowMapper(RequestMapper.class)
    List<Request> getAllRequests();

    @SqlQuery("SELECT * FROM requests WHERE user_id = ?")
    @UseRowMapper(RequestMapper.class)
    List<Request> getRequestsByUser(int user_id);

    @SqlQuery("SELECT * FROM requests WHERE dog_id = ?")
    @UseRowMapper(RequestMapper.class)
    List<Request> getRequestsByDog(int dog_id);

    @SqlQuery("SELECT * FROM requests WHERE dog_id LIKE CONCAT('%',:searchTerm,'%') OR user_id LIKE CONCAT('%',:searchTerm,'%') OR req_text LIKE CONCAT('%',:searchTerm,'%')")
    @UseRowMapper(RequestMapper.class)
    List<Request> getSearchRequest(@Bind("searchTerm") String searchTerm);

    @SqlUpdate("INSERT INTO requests(dog_id, user_id, req_text) VALUES (?, ?, ?)")
    int addRequest(int dog_id, int user_id, String req_text);

}
