package org.lanqiao;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
public class SpringMVCconfig extends WebMvcConfigurerAdapter {

	
	@Bean
    public FilterRegistrationBean characterEncodingFilter() {
		FilterRegistrationBean registration = new FilterRegistrationBean();
        CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
        characterEncodingFilter.setForceEncoding(true);
        registration.setFilter(characterEncodingFilter);
        registration.addUrlPatterns("/*");
        registration.addInitParameter("encoding", "UTF-8");
        registration.setName("encodingFilter");
        return registration;
    }
	
}
