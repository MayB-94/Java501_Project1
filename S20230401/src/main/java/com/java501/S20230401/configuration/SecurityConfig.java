package com.java501.S20230401.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.LogoutHandler;

import com.java501.S20230401.handler.ShareGoLoginSuccessHandler;
import com.java501.S20230401.handler.ShareGoLogoutHandler;
import com.java501.S20230401.handler.ShareGoLogoutSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
	@Bean
	public BCryptPasswordEncoder encodePwd() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	public AuthenticationSuccessHandler successHandler() {
		return new ShareGoLoginSuccessHandler("/");
	}
	
	@Bean
	protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
//		http.csrf().disable();
//		http.authorizeRequests().anyRequest().permitAll();
//		return http.build();
		http.csrf().disable(); // 추후 각주처리... POST 마다 CSRF TOKEN 값을 hidden type으로 넣어주면 됨...
		http.authorizeRequests()
			.antMatchers("/user/**").authenticated()
			.antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')")
			//.antMatchers("/admin/**").authenticated()
			.anyRequest().permitAll()
			.and()
			.formLogin()
			.loginPage("/login")
			.loginProcessingUrl("/loginProc")
			//.defaultSuccessUrl("/")
			.successHandler(successHandler())
			.and()
			.logout()
			////.logoutSuccessUrl("/")
			//.addLogoutHandler(new ShareGoLogoutHandler())
			.logoutSuccessHandler(new ShareGoLogoutSuccessHandler())
			.invalidateHttpSession(true);
		return http.build();
	}
}
