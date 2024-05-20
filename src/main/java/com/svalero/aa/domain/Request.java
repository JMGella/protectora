package com.svalero.aa.domain;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Request {
    private int req_id;
    private int dog_id;
    private int user_id;
    private String req_text;
    private String city;
}
