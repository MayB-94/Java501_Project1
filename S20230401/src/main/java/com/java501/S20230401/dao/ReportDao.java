package com.java501.S20230401.dao;

import java.util.List;

import com.java501.S20230401.model.Report;

public interface ReportDao {
	// 유현규
	public int hgGetCountAllUnprocessedReports();
	public List<Report> hgGetAllUnprocessedReports(Report report);
	public Object hgGetInstanceByReportId(int report_id, String pascalClassName);
	public int hgUpdateInstanceAboutReport(Report report, String pascal);
	public int hgUpdateReportBatch(Report report);
	public int hgRejectReport(Report report);
	
	// 김찬영
	int 		cyReportinsert(Report report);

	
	// 양동균
	int shareReport(Report report); // 신고
	boolean shareIsReport(Report report);

}
