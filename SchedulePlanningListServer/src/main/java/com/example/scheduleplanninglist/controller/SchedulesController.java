package com.example.scheduleplanninglist.controller;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.StrUtil;
import com.example.scheduleplanninglist.bo.ScheduleRequest;
import com.example.scheduleplanninglist.common.Constant;
import com.example.scheduleplanninglist.common.R;
import com.example.scheduleplanninglist.entity.Categories;
import com.example.scheduleplanninglist.entity.Schedules;
import com.example.scheduleplanninglist.entity.Users;
import com.example.scheduleplanninglist.service.ICategoriesService;
import com.example.scheduleplanninglist.service.ISchedulesService;
import com.example.scheduleplanninglist.service.IUsersService;
import com.example.scheduleplanninglist.vo.ScheduleVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.List;


@RestController
@RequestMapping("/schedules")
public class SchedulesController {

    @Resource
    private IUsersService usersService;

    @Resource
    private ISchedulesService schedulesService;

    @Resource
    private ICategoriesService categoriesService;

    @PostMapping("/list")
    public R list(@RequestBody ScheduleRequest request, HttpServletRequest httpServletRequest) {
        List<ScheduleVO> list = schedulesService.lambdaQuery()
                // 等于查询，查询用户 ID 等于请求中用户 ID 的日程
                .eq(Schedules::getUserId, request.getUserId())
                // 模糊查询，当搜索关键词不为空时，查询内容包含搜索关键词的日程
                .like(StrUtil.isNotEmpty(request.getSearchKey()), Schedules::getContent, request.getSearchKey())
                // 按更新时间降序（Desc）排列，若更新时间相同则按创建时间降序排列。升序为（asc）
                .orderByDesc(Schedules::getUpdateTime, Schedules::getCreateTime)//执行查询并获取结果列表
                .list()
                // 将每个查询结果对象映射为 ScheduleVO 对象
                .stream()
                .map(it -> {
                    ScheduleVO scheduleVO = BeanUtil.copyProperties(it, ScheduleVO.class);
                    Categories categories = categoriesService.getById(scheduleVO .getCategoryId());// 根据类别 ID 查询类别信息
                    if (categories != null) {
                        categories.setIconSelected(Constant.getFileUrl(httpServletRequest, categories.getIcon())); // 设置选中状态下的图标 URL
                        categories.setIcon(Constant.getFileUrl(httpServletRequest, categories.getIcon())); // 设置图标 URL
                    }
                    scheduleVO.setCategory(categories);
                    return scheduleVO;
                })
                .toList();// 将流收集为列表
        return R.ok(list);
    }


    @PostMapping("/addOrUpdate")
    public R addOrUpdate(@RequestBody ScheduleRequest request) {
        if (StrUtil.isEmpty(request.getContent())) {
            return R.error("内容为空");
        }
        Categories categories = categoriesService.getById(request.getCategoryId());
        if (categories == null) {
            return R.error("category not found");
        }

        Users users = usersService.getById(request.getUserId());
        if (users == null) {
            return R.error("user not found");
        }
        Schedules byId = schedulesService.getById(request.getId());
        //获取/创建日程对象
        if (byId == null) {  //如果前端传回来的日程ID在数据库不存在，则将当前时间放入“创建时间”，反之放进“更新时间”
            byId = new Schedules();
            byId.setCreateTime(LocalDateTime.now());// 设置创建时间
        } else {
            byId.setUpdateTime(LocalDateTime.now());// 设置更新时间
        }
        byId.setContent(request.getContent());
        byId.setCategoryId(categories.getId());
        byId.setUserId(users.getId());
        return R.ok(schedulesService.saveOrUpdate(byId));//保存或更新数据---返回操作结果
    }

    @PostMapping("/remove")
    public R remove(@RequestBody ScheduleRequest request) {
        List<Integer> ids = request.getIds();
        if (ids == null || ids.isEmpty()) {
            return R.error("删除失败");
        }
        return R.ok(schedulesService.removeBatchByIds(ids));
    }
}
