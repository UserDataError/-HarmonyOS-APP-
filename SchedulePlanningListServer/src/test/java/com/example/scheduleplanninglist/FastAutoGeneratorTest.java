package com.example.scheduleplanninglist;

import cn.hutool.core.io.FileUtil;
import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.IFill;
import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
import com.baomidou.mybatisplus.generator.config.OutputFile;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class FastAutoGeneratorTest {

    /**
     * 数据源配置
     */
    private static final DataSourceConfig.Builder DATA_SOURCE_CONFIG = new DataSourceConfig
            .Builder(
            "jdbc:mysql://localhost:3306/schedule_planning_list?serverTimezone=GMT%2b8",
            "root",
            "qwe123");


    /**
     * 执行 run
     */
    public static void main(String[] args) {
        String projectPath =  System.getProperty("user.dir")+"/test";

        System.out.println("projectPath=" + projectPath);
        FileUtil.del(projectPath);

        List<IFill> tables = new ArrayList<>();


        Map<OutputFile, String> pathInfo = new HashMap<>();
        pathInfo.put(OutputFile.xml, projectPath + "/src/main/resources/mapper/scheduleplanninglist");
        FastAutoGenerator.create(DATA_SOURCE_CONFIG)
                // 全局配置
                .globalConfig(builder -> builder
                        .outputDir(projectPath + "/src/main/java")
                        .disableOpenDir()
                )
                // 包配置
                .packageConfig(builder -> builder
                        .parent("com.example")
                        .moduleName("scheduleplanninglist")
                        .pathInfo(pathInfo)
                )
                .strategyConfig((scanner, builder) -> builder
                        .entityBuilder()
                        .enableLombok()
                        .addTableFills(tables)
                        .controllerBuilder()
                        .enableRestStyle()
                        .enableHyphenStyle())

                .execute();
    }
}
