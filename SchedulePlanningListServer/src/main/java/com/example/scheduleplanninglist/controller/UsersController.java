package com.example.scheduleplanninglist.controller;

import cn.hutool.core.util.StrUtil;
import com.example.scheduleplanninglist.bo.LoginOrRegisterBO;
import com.example.scheduleplanninglist.common.Constant;
import com.example.scheduleplanninglist.common.R;
import com.example.scheduleplanninglist.entity.Users;
import com.example.scheduleplanninglist.service.IUsersService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/users")
public class UsersController {

    @Resource
    private IUsersService usersService;

    @PostMapping("/register")
    public R register(@RequestBody LoginOrRegisterBO request) {
        if (StrUtil.isEmpty(request.getPhone())) {
            return R.error("手机号不能为空");
        }

        if (StrUtil.isEmpty(request.getNickname())) {
            return R.error("用户昵称不能为空");
        }

        if (StrUtil.isEmpty(request.getPassword())) {
            return R.error("密码不能为空");
        }

        Long count = usersService.lambdaQuery()
                .eq(Users::getPhone, request.getPhone()).count();
        if (count > 0) {
            return R.error("手机号已经被注册");
        }

        Users users = new Users();
        users.setPhone(request.getPhone());
        users.setNickname(request.getNickname());
        users.setPassword(request.getPassword());
        users.setCreateTime(LocalDateTime.now());
        boolean save = usersService.save(users);// 执行存储操作
        if (save) {
            return R.ok(true);
        }
        return R.error("注册失败");
    }


    @PostMapping("/login")
    public R login(@RequestBody LoginOrRegisterBO request, //接受前端传回的数据
                   HttpServletRequest httpServletRequest) {// 获取HTTP请求对象
        Users users = usersService.lambdaQuery()
                .eq(Users::getPhone, request.getPhone())
                .eq(Users::getPassword, request.getPassword())
                .one();//返回单个用户对象


        if (users == null) {
            return R.error("手机号或者密码错误");
        }

        users.setAvatar(Constant.getAvatarUrl(httpServletRequest, users.getAvatar()));
        return R.ok(users);
    }
}
