package com.java501.S20230401.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.java501.S20230401.model.Report;

import lombok.RequiredArgsConstructor;


@Repository
@RequiredArgsConstructor
public class ReportDaoImpl implements ReportDao {

	private final SqlSession session;
		
	@Override
	public int cyReportinsert(Report report) {
		System.out.println("신고 다오임플 작성");
		int result=0;
		try {
			result = session.insert("cyReportinsert", report);
		} catch (Exception e) {
			System.out.println("신고임플 getMessage()->"+e.getMessage());
		}
		return result;
	}

	
	// 유현규
	@Override
	public int hgGetCountAllUnprocessedReports() {
		return session.selectOne("hgGetCountAllUnprocessedReports");
	}
	 @Override
	public List<Report> hgGetAllUnprocessedReports(Report report) {
		return session.selectList("hgGetAllUnprocessedReports", report);
	}
	@Override
	public Object hgGetInstanceByReportId(int report_id, String pascalClassName) {
		return session.selectOne("hgGet" + pascalClassName + "ByReportId", report_id);
	}
	@Override
	public int hgUpdateInstanceAboutReport(Report report, String pascal) {
		return session.update(String.format("hgUpdate%sAboutReport", pascal), report);
	}
	@Override
	public int hgUpdateReportBatch(Report report) {
		return session.update("hgUpdateReportBatch", report);
	}
	@Override
	public int hgRejectReport(Report report) {
		return session.delete("hgRejectReport", report);
	}

	// 양동균
	@Override
	public int shareReport(Report report) {
		int result = 0;
		try {
			System.out.println("삽입"+report);
			result = session.insert("dgShareReport", report);
			if(result > 0)
				result = report.getReport_id();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	// 신고 체크
	@Override
	public boolean shareIsReport(Report report) {
		boolean isReport = false;
		try {
			isReport = session.selectOne("dgshareIsReport", report);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isReport;
	}



}
