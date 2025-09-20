package com.example.scheduleplanninglist.controller;

import cn.hutool.core.io.FileUtil;
import com.example.scheduleplanninglist.common.Constant;
import com.example.scheduleplanninglist.common.R;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

@RestController
@RequestMapping("/upload")
public class UploadAPIController {



    @PostMapping("/img")
    public R uploadImg(@RequestParam MultipartFile file, HttpServletRequest request) throws IOException {

        if (file.isEmpty()) {
            return R.error();
        }

        String originalFilename = file.getOriginalFilename();
        if (originalFilename == null) {
            return R.error();
        }
        File path = new File(System.getProperty("user.dir") + "/static/img");
        if (!path.exists()) {
            path.mkdirs();
        }

        File dest = new File(path, originalFilename);
        if (dest.exists()) {
            dest.delete();
        }

        FileUtil.writeFromStream(file.getInputStream(), dest);

        return R.ok(Constant.getFileUrl(request, originalFilename));
    }

}
