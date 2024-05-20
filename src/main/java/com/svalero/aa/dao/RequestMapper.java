package com.svalero.aa.dao;

import com.svalero.aa.domain.Request;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class RequestMapper implements RowMapper<Request> {

    @Override
    public Request map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Request(rs.getInt("req_id"),
                rs.getInt("dog_id"),
                rs.getInt("user_id"),
                rs.getString("req_text"));
    }
}
