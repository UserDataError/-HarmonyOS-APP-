package com.example.scheduleplanninglist.bo;//业务对象

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Setter
@Getter
public class ScheduleRequest {

    private Integer id;
    private String content;
    private Integer categoryId;
    private Integer userId;

    private List<Integer> ids;
    private String searchKey;
}
