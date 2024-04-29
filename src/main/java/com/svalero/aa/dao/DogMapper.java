package com.svalero.aa.dao;

import com.svalero.aa.domain.Dog;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class DogMapper implements RowMapper<Dog> {

    @Override
    public Dog map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Dog(rs.getInt("id"),
                rs.getString("name"),
                rs.getDate("birth"),
                rs.getString("sex"),
                rs.getString("breed"),
                rs.getString("weight"),
                rs.getString("description"),
                rs.getString("picture"),
                 rs.getInt("adopted"));
    }
}
