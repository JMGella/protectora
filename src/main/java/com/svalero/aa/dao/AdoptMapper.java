package com.svalero.aa.dao;


import com.svalero.aa.domain.Adoption;
import com.svalero.aa.domain.Favorite;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class AdoptMapper implements RowMapper<Adoption> {

    @Override
    public Adoption map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Adoption(rs.getInt("adp_id"),
                rs.getInt("dog_id"),
                rs.getInt("user_id"));
    }
}
