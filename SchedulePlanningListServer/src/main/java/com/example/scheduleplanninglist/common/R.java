package com.example.scheduleplanninglist.common;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
public class R {

    private Integer code;
    private String msg;
    private Object data;


    public static R ok() {
        return new R(0, "合理安排每一天", null);
    }

    public static R ok(Object data) {
        return new R(0, "合理安排每一天", data);
    }


    public static R error(String message) {
        return new R(1, message, null);
    }

    public static R error(String message, int code) {
        return new R(code, message, null);
    }

    public static R error(int code, String message) {
        return new R(code, message, null);
    }


    public static R error() {
        return new R(1, "", null);
    }


}
