package com.java501.S20230401.model;

import java.util.ArrayList;
import java.util.Collection;

//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

//import com.java501.S20230401.dao.CommDao;

import lombok.Data;

@Data
public class MemberDetails implements UserDetails {
	private final MemberInfo memberInfo;
//	@Autowired
//	private CommDao cd;
	
	public MemberDetails(MemberInfo memberInfo) {
		this.memberInfo = memberInfo;
	}
	
	// 유현규
	@Override
	public String getPassword() {
		return memberInfo.getMem_password();
	}
	
	@Override
	public String getUsername() {
		return memberInfo.getMem_username();
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection<GrantedAuthority> collect = new ArrayList<>();
		//String role = cd.getValueById(memberInfo.getMem_authority());
		String role = null;
		switch(memberInfo.getMem_authority()) {
			case 101: role = "ROLE_GUEST"; break;
			case 102: role = "ROLE_BANNED"; break;
			case 103: role = "ROLE_USER"; break;
			case 108: role = "ROLE_MANAGER"; break;
			case 109: role = "ROLE_ADMIN"; break;
		}
		collect.add(new SimpleGrantedAuthority(role));
		return collect;
	}
	
	@Override
	public boolean isEnabled() {
		return memberInfo.getIsdelete() == 0;
	}
	
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
}
