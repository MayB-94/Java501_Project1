package com.java501.S20230401.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Member;
import com.java501.S20230401.model.MemberInfo;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MemberDaoImpl implements MemberDao {
	private final SqlSession session;
	
	
	// 양동균
	@Override
	public int dgReportMember(Member member) {
		int result = 0;
		try {
			result = session.update("dgReportMember", member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	// 유저 체크
	@Override
	public Integer dgCheckUser(String mem_username) {
		Integer result = 0;
		try {
			result = session.selectOne("dgCheckUser", mem_username);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 유현규
	@Override
	public Member findByMemberUsername(String username) {
		return session.selectOne("hgGetMemberByUsername", username);
	}
	@Override
	public Member findByMemberEmail(String email) {
		return session.selectOne("hgGetMemberByEmail", email);
	}
	@Override
	public Member findByMemberNickname(String nickname) {
		return session.selectOne("hgGetMemberByNickname", nickname);
	}
	@Override
	public Member hgFindByMemberUsername(Map<String, Object> param) {
		return session.selectOne("hgGetMemberByUsernameWithExcept", param);
	}
	public Member hgFindByMemberEmail(Map<String, Object> param) {
		return session.selectOne("hgGetMemberByEmailWithExcept", param);
	}
	public Member hgFindByMemberNickname(Map<String, Object> param) {
		return session.selectOne("hgGetMemberByNicknameWithExcept", param);
	}
	
	@Override
	public MemberInfo findByMemberInfoName(String username) {
		return session.selectOne("hgGetMemberInfoByUsername", username);
	}
	@Override
	public int registMember(Member member) {
		return session.insert("hgRegistMember", member);
	}
	@Override
	public Member getMemberById(int mem_id) {
		return session.selectOne("hgGetMemberById", mem_id);
	}
	@Override
	public void setAuthority(Integer mem_id, int authority) {
		Member member = new Member();
		member.setMem_id(mem_id);
		member.setMem_authority(authority);
		session.update("hgSetAuthority", member);
	}



	@Override
	public int hgGetCountAllMembers() {
		return session.selectOne("hgGetCountAllMembers");
	}
	@Override
	public List<Member> hgGetMembersForAdmin(Member member) {
		return session.selectList("hgGetMembersForAdmin", member);
	}
	@Override
	public int hgUpdateAuthorityByMember(Member member) {
		return session.update("hgUpdateAuthorityByMember", member);
	}
	@Override
	public int hgUpdateIsdeleteByMember(Member member) {
		return session.update("hgUpdateIsdeleteByMember", member);
	}
	@Override
	public int hgUpdateMember(Member member) {
		return session.update("hgUpdateMember", member);
	}
	@Override
	public int hgDeleteAccount(Integer mem_id) {
		return session.update("hgDeleteAccount", mem_id);
	}
	@Override
	public int hgUpdatePassword(Member member) {
		return session.update("hgUpdatePassword", member);
	}
	@Override
	public Member hgGetMemberByNameAndEmail(Member member) {
		return session.selectOne("hgGetMemberByNameAndEmail", member);
	}
}
