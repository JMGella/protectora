package com.svalero.aa.domain;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@NoArgsConstructor
@AllArgsConstructor
@Data
public class Favorite {
    private int fav_id;
    private int dog_id;
    private int user_id;

}