package com.example.scheduleplanninglist.bo;//业务对象

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class LoginOrRegisterBO {

    private String phone;

    private String password;

    private String nickname;

    private String avatar;

    private String sex;
    private String role;
    private Integer webStatus;

    private Integer userId;
    private Integer id;
}
