package com.example.scheduleplanninglist.controller;


import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.StrUtil;
import com.example.scheduleplanninglist.common.Constant;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;


@RestController
@RequestMapping("/static")
public class StaticAPIController {


    @GetMapping("/{type}/{name}")
    public ResponseEntity<Resource> getStatic(@PathVariable String type, @PathVariable String name) {
        if (StrUtil.equals(type, "img")) {
            File file = new File(Constant.IMG_PATH, name);
            if (!file.exists()) {
                return ResponseEntity.noContent().build();
            }
            String contentType = FileUtil.getMimeType(file.getAbsolutePath());
            if (contentType == null) {
                contentType = "application/octet-stream";
            }
            Resource resource = new FileSystemResource(file);
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(contentType))
                    .body(resource);
        } else {
            return ResponseEntity.noContent().build();
        }
    }


}
