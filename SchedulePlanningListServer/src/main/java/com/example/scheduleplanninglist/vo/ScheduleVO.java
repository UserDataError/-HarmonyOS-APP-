package com.example.scheduleplanninglist.vo;
// 表现对象. 主要用于与前端直接的交互与信息传递
//将前端的数据传回后端
import com.example.scheduleplanninglist.entity.Categories;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Setter
@Getter
public class ScheduleVO {

    private Integer id;

    private Integer userId;

    private String content;

    private Integer categoryId;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
    private Categories category;
}
