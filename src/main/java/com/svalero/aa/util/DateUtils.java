package com.svalero.aa.util;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import static com.svalero.aa.util.Constants.*;

public class DateUtils {

    public static String format(Date date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(FORMAT_DATE_PATTERN);
        return dateFormat.format(date);
    }

    public static Date parse(String date) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat(PARSE_DATE_PATTERN);
        return new Date(dateFormat.parse(date).getTime());
    }

}


