package org.lanqiao;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.DispatcherServlet;
@EnableAutoConfiguration
@SpringBootApplication
public class App {

	
	/**
	 * 自定义配置springmvc映射路径
	 * @param dispatcherServlet
	 * @return
	 */
	@Bean
    public ServletRegistrationBean apiV1ServletBean(WebApplicationContext wac) {
        DispatcherServlet ds = new DispatcherServlet(wac);
        ServletRegistrationBean bean = new ServletRegistrationBean(ds, "*.do");
        bean.setName("ddddddddddddd");
       //bean.addUrlMappings("*.do");
       return bean;
   }
	/*@Bean
	public ServletRegistrationBean webbbbbb(WebAppConfig webAppConfig) {
		ServletRegistrationBean registration = new ServletRegistrationBean(webAppConfig);
		registration.addUrlMappings("/");
		return registration;
	}*/
	
	public static void main(String[] args) {
		SpringApplication.run(App.class, args);
	}
	
}
