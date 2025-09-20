package com.example.scheduleplanninglist.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author baomidou
 * @since 2025-05-19
 */
@Getter
@Setter
@ToString
public class Categories implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String name;

    /**
     * 0——工作，1——娱乐
     */
    private Integer type;
    private Integer sort;

    private String icon;

    private String iconSelected;
}
