package com.svalero.aa.domain;

import com.svalero.aa.dao.Database;
import com.svalero.aa.dao.DogDao;
import com.svalero.aa.dao.FavDao;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.jdbi.v3.sqlobject.statement.SqlQuery;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Favorite {
    private int fav_id;
    private int dog_id;
    private int user_id;

}