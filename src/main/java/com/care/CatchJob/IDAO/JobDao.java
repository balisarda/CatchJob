package com.care.CatchJob.IDAO;

import java.util.List;

import com.care.CatchJob.DTO.Apply;
import com.care.CatchJob.DTO.Job;



public interface JobDao {
	public void AddJob(Job job);
	public List<Job> FindJob();
	public List<Job> InfoJobById(String member_nickname);
	public List<Job> InfoJobByNo(String member_nickname);
	public void DeleteJob(String no);
	public void DeleteApply(Apply apply);
	public void UpdateJob(Job job);
	public void applyInfo(Apply apply);
	public String GetApplyNum(String apply_no);
	public String chkDuplicate(Apply apply);
	public List<Apply> GetApplyNo(String member_nickname);
}