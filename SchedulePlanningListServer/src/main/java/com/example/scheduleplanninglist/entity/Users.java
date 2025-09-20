package com.example.scheduleplanninglist.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.time.LocalDateTime;

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
public class Users implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String phone;

    private String password;

    private String nickname;

    private String avatar;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    private String role;

    private Integer deleted;
}
