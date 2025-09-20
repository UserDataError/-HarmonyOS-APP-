package com.example.scheduleplanninglist.config;

import lombok.Data;
@Data
public class Result {

        private Long code;
        private String msg;
        private Object data;


        public Result(Long code, String msg, Object data) {
            this.code = code;
            this.msg = msg;
            this.data = data;
        }

        /**
         * 响应成功 不返回数据
         * @return
         */
        public static Result success() {
            return new Result(200L,"",null);
        }
        /**
         * 响应成功 返回数据
         * @return
         */
        public static Result success(Object data) {
            return new Result(200L,"操作成功",data);
        }
        /**
         * 响应失败 返回错误信息
         * @return
         */
        public static Result error(String message) {
            return new Result(405L,message,null);
        }



}
