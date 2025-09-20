package com.example.scheduleplanninglist.common;


import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;

import jakarta.servlet.http.HttpServletRequest;

import java.util.List;

public class Constant {


    public static String RESOURCE_BASE_PATH = System.getProperty("user.dir") + "/static";
    public static String IMG_PATH = RESOURCE_BASE_PATH + "/img";

    public static String getFileUrl(HttpServletRequest request, String path) {
        if (!StrUtil.isEmpty(path)) {
            return request.getRequestURL().toString().replace(request.getRequestURI(), "") + "/api/static/img/" + path;
        }
        return "";
    }

    public static String getAvatarUrl(HttpServletRequest request, String path) {
        if (!StrUtil.isEmpty(path)) {
            return request.getRequestURL().toString().replace(request.getRequestURI(), "") + "/api/static/img/" + path;
        }
        return  request.getRequestURL().toString().replace(request.getRequestURI(), "") + "/api/static/img/icon_user.png";
    }


    public static String filePathsToJsonStr(List<String> paths) {
        if (!CollectionUtil.isEmpty(paths)) {
            return JSONUtil.toJsonStr(paths);
        } else {
            return "";
        }
    }

    public static String getFileNameFromUrl(String path) {
        if (StrUtil.isEmpty(path)) {
            return "";
        }
        if (!path.contains("/")) {
            return path;
        }
        return path.substring(path.lastIndexOf("/") + 1);
    }

}
