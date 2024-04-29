package com.svalero.aa.dao;

import com.svalero.aa.domain.Dog;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.sql.Date;
import java.util.List;

public interface DogDao {
    @SqlQuery("SELECT * FROM perros")
    @UseRowMapper(DogMapper.class)
    List<Dog> getAllDogs();

    @SqlQuery("SELECT * FROM perros WHERE id = ?")
    @UseRowMapper(DogMapper.class)
    Dog getDog(int id);

    @SqlQuery("SELECT * FROM perros WHERE name LIKE CONCAT('%',:searchTerm,'%') OR description LIKE CONCAT('%',:searchTerm,'%') OR breed LIKE CONCAT('%',:searchTerm,'%')")
    @UseRowMapper(DogMapper.class)
    List<Dog> getSearchDogs(@Bind("searchTerm") String searchTerm);

    @SqlUpdate("INSERT INTO perros(name, birth, sex, breed, weight, description, picture) VALUES (?, ?, ?, ?, ?, ? ,?)")
    int addDog(String name, Date birth, String sex, String breed, String weight, String description, String picture);

    @SqlUpdate("UPDATE perros SET name = ?, birth = ?, sex = ?, breed = ?, weight = ?, description = ?, picture = ? WHERE id = ?")
    int updateDog(String name, Date birth, String sex, String breed, String weight, String description, String picture, int id);

    @SqlUpdate("DELETE FROM perros WHERE id = ?")
    int removeDog(int id);


    @SqlUpdate("UPDATE perros SET adopted = 1  WHERE id = ?")
    int adoptDog(int id);

}
