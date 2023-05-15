package com.java501.S20230401.dao;


import java.util.List;
import java.util.Map;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Member;
import com.java501.S20230401.model.MemberInfo;

public interface MemberDao {

	// 양동균
	int dgReportMember(Member member);
	Integer dgCheckUser(String mem_username);

	// 유현규
	public Member findByMemberUsername(String username);
	public Member findByMemberEmail(String email);
	public Member findByMemberNickname(String nickname);
	public MemberInfo findByMemberInfoName(String username);
	public int registMember(Member member);
	public Member getMemberById(int mem_id);
	public void setAuthority(Integer mem_id, int authority);
	public int hgGetCountAllMembers();
	public List<Member> hgGetMembersForAdmin(Member member);
	public int hgUpdateAuthorityByMember(Member member);
	public int hgUpdateIsdeleteByMember(Member member);
	public Member hgFindByMemberUsername(Map<String, Object> param);
	public Member hgFindByMemberEmail(Map<String, Object> param);
	public Member hgFindByMemberNickname(Map<String, Object> param);
	public int hgUpdateMember(Member member);




}
