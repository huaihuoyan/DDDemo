package com.huai.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @Author: laiyunjing
 * @Description : 改变静态资源访问路径
 * @Date: Created in 2019-07-13 11:50
 */
@Configuration
public class StaticPathConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

        //映射项目中的静态资源
        registry.addResourceHandler("/huai/**")
                    .addResourceLocations("classpath:/static/");

//        //下载的虚拟路径映射
//        registry.addResourceHandler("/fileres/**")
//                    .addResourceLocations("file:///D:/fileStorage/uploads/");
    }
}
