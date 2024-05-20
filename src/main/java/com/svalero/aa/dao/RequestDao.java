package com.svalero.aa.dao;
import com.svalero.aa.domain.Dog;
import com.svalero.aa.domain.Request;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;

public interface RequestDao {
    @SqlQuery("SELECT * FROM request")
    @UseRowMapper(RequestMapper.class)
    List<Request> getAllRequests();

    @SqlQuery("SELECT * FROM request WHERE user_id = ?")
    @UseRowMapper(RequestMapper.class)
    List<Request> getRequestsByUser(int user_id);

    @SqlQuery("SELECT * FROM request WHERE dog_id = ?")
    @UseRowMapper(RequestMapper.class)
    List<Request> getRequestsByDog(int dog_id);

    @SqlQuery("SELECT * FROM request WHERE dog_id LIKE CONCAT('%',:searchTerm,'%') OR user_id LIKE CONCAT('%',:searchTerm,'%') OR req_text LIKE CONCAT('%',:searchTerm,'%') OR city LIKE CONCAT('%',:searchTerm,'%')")
    @UseRowMapper(RequestMapper.class)
    List<Request> getSearchRequest(@Bind("searchTerm") String searchTerm);

    @SqlUpdate("INSERT INTO request(dog_id, user_id, req_text, city) VALUES (?, ?, ? ,?)")
    int addRequest(int dog_id, int user_id, String req_text, String city);

    @SqlUpdate("DELETE FROM request WHERE req_id = ?")
    int removeRequest(int req_id);

    @SqlUpdate("DELETE FROM request WHERE user_id = ?")
    int removeRequestbyUser(int user_id);

    @SqlUpdate("DELETE FROM request WHERE dog_id = ?")
    int removeRequestbyDog(int dog_id);

    @SqlQuery("SELECT * FROM request WHERE req_id = ?")
    @UseRowMapper(RequestMapper.class)
    Request getRequestById(int req_id);

    @SqlUpdate("UPDATE request SET dog_id = ?, user_id = ?, req_text = ?, city = ? WHERE req_id = ?")
    int updateRequest(int dog_id, int user_id, String req_text, String city, int req_id);

}
