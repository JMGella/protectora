package com.svalero.aa.domain;


import com.svalero.aa.dao.Database;
import com.svalero.aa.dao.FavDao;
import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import java.sql.Date;

@NoArgsConstructor
@AllArgsConstructor
@Data


public class Dog {
    private int id;
    private String name;
    private Date birth;
    private String sex;
    private String breed;
    private String weight;
    private String description;
    private String picture;
    private int adopted;


    public int favcount() {
        return Database.jdbi.withExtension(FavDao.class, dao -> dao.getFavCount(id));

    }
}
