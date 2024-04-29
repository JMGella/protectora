package com.svalero.aa.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Adoption {
    private int adp_id;
    private int dog_id;
    private int user_id;
}
