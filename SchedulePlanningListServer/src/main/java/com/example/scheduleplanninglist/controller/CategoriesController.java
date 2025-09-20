package com.example.scheduleplanninglist.controller;

import com.example.scheduleplanninglist.bo.CategoriesRequest;
import com.example.scheduleplanninglist.common.Constant;
import com.example.scheduleplanninglist.common.R;
import com.example.scheduleplanninglist.entity.Categories;
import com.example.scheduleplanninglist.service.ICategoriesService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@RestController
@RequestMapping("/categories")
public class CategoriesController {

    @Resource
    private ICategoriesService categoriesService;

    @PostMapping("/list")
    public R list(@RequestBody CategoriesRequest request, HttpServletRequest httpServletRequest) {
        // 执行数据库查询并排序
        List<Categories> list = categoriesService.lambdaQuery()
                .orderByDesc(Categories::getSort)
                .list().stream()
                .peek(it -> {
                    it.setIcon(Constant.getFileUrl(httpServletRequest, it.getIcon()));
                    it.setIconSelected(Constant.getFileUrl(httpServletRequest, it.getIconSelected()));
                })
                .toList();
        return R.ok(list);
    }
}
