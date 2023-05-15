package com.java501.S20230401.service;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.java501.S20230401.dao.MemberDao;
import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Member;
import com.java501.S20230401.util.MemberSearchKeyword;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
	private final MemberDao md;
	
	// 양동균
	@Override
	public int dgReportMember(Member member) { return md.dgReportMember(member); }
	@Override
	public Integer dgCheckUser(String mem_username) { return md.dgCheckUser(mem_username); }

	// 유현규
	@Override
	public Member getMember(String keyword, MemberSearchKeyword type) {
		Member member = null;
		switch(type) {
			case USERNAME: member = md.findByMemberUsername(keyword); break;
			case EMAIL: member = md.findByMemberEmail(keyword); break;
			case NICKNAME: member = md.findByMemberNickname(keyword); break;
			default: break;
		}
		return member;
	}
	
	@Override
	public Member hgGetMemberWithExcept(Map<String, Object> param, MemberSearchKeyword type) {
		Member member = null;
		switch(type) {
			case USERNAME: member = md.hgFindByMemberUsername(param); break;
			case EMAIL: member = md.hgFindByMemberEmail(param); break;
			case NICKNAME: member = md.hgFindByMemberNickname(param); break;
			default: break;
		}
		return member;
	}
	
	@Override
	public int registMember(Member member) {
		return md.registMember(member);
	}
	
	@Override
	public Member getMemberById(int mem_id) {
		return md.getMemberById(mem_id);
	}
	
	@Override
	public void setAuthority(Integer mem_id, int authority) {
		md.setAuthority(mem_id, authority);
	}


	
	@Override
	public int hgGetCountAllMembers() {
		return md.hgGetCountAllMembers();
	}
	
	@Override
	public List<Member> hgGetMembersForAdmin(Member member) {
		return md.hgGetMembersForAdmin(member);
	}
	
	@Override
	public int hgUpdateAuthorityByMember(Member member) {
		return md.hgUpdateAuthorityByMember(member);
	}
	
	@Override
	public int hgUpdateIsdeleteByMember(Member member) {
		return md.hgUpdateIsdeleteByMember(member);
	}
	
	@Override
	public int hgUpdateMember(Member member) {
		return md.hgUpdateMember(member);
	}
}
