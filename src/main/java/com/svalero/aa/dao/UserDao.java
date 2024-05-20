package com.svalero.aa.dao;


import com.svalero.aa.domain.Dog;
import com.svalero.aa.domain.User;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;
import java.util.List;

public interface UserDao {
    @SqlQuery("SELECT * FROM users")
    @UseRowMapper(UserMapper.class)
    List<User> getAllUsers();

    @SqlQuery("SELECT * FROM users WHERE id = ?")
    @UseRowMapper(UserMapper.class)
    User getUserid(int id);

    @SqlQuery("SELECT * FROM users WHERE username = ? AND password = SHA1(?)")
    @UseRowMapper(UserMapper.class)
    User getUser(String username, String password);

    @SqlUpdate("INSERT INTO users (name, username, password, role) VALUES (?, ?, SHA1(?), ?)")
    int addUser(String name, String username, String password, String role);

    @SqlQuery("SELECT * FROM users WHERE name LIKE CONCAT('%',:searchTerm,'%') OR username LIKE CONCAT('%',:searchTerm,'%')")
    @UseRowMapper(UserMapper.class)
    List<User> getSearchUsers(@Bind("searchTerm") String searchTerm);

    @SqlUpdate("DELETE FROM users WHERE id = ?")
    int removeUser(int id);

}



