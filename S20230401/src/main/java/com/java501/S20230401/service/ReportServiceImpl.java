package com.java501.S20230401.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.java501.S20230401.dao.ReportDao;
import com.java501.S20230401.model.Report;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReportServiceImpl implements ReportService {
	private final ReportDao pd;
	@Override
	public int cyReportinsert(Report report) {
		System.out.println("신고 작성 서비스임플");
		int result = pd.cyReportinsert(report);
		return result;
	}
	
	// 유현규
	@Override
	public int hgGetCountAllUnprocessedReports() {
		return pd.hgGetCountAllUnprocessedReports();
	}
	@Override
	public List<Report> hgGetAllUnprocessedReports(Report report) {
		return pd.hgGetAllUnprocessedReports(report);
	}
	@Override
	public Object hgGetInstanceByReportId(int report_id, String pascalClassName) {
		return pd.hgGetInstanceByReportId(report_id, pascalClassName);
	}
	@Override
	public int hgUpdateInstanceAboutReport(Report report, String pascal) {
		return pd.hgUpdateInstanceAboutReport(report, pascal);
	}
	@Override
	public int hgUpdateReportBatch(Report report) {
		return pd.hgUpdateReportBatch(report);
	}
	@Override
	public int hgRejectReport(Report report) {
		return pd.hgRejectReport(report);
	}
	
	// 양동균
	@Override
	public int shareReport(Report report) { return pd.shareReport(report); }

	@Override
	public boolean shareIsReport(Report report) { return pd.shareIsReport(report); }

}
