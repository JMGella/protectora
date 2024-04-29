package com.svalero.aa.dao;


import com.svalero.aa.domain.Favorite;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class FavMapper implements RowMapper<Favorite> {

    @Override
    public Favorite map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Favorite(rs.getInt("fav_id"),
                rs.getInt("dog_id"),
                rs.getInt("user_id"));
    }

}
