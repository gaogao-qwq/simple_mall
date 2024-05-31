package com.gaogaoqwq.mall.exception;

import java.time.Instant;
import java.util.Date;
import org.springframework.http.HttpStatus;

public class DateConflictException extends MallException {

    public DateConflictException(Date from, Date to) {
        super(String.format("Date from(%s) is later than to(%s)", from, to),
                HttpStatus.BAD_REQUEST);
    }

    public DateConflictException(Instant from, Instant to) {
        super(String.format("Date from(%s) is later than to(%s)",
                Date.from(from), Date.from(to)),
                HttpStatus.BAD_REQUEST);
    }

}
