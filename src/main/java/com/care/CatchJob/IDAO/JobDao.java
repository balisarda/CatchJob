package com.care.CatchJob.IDAO;

import java.util.List;

import com.care.CatchJob.DTO.Job;

public interface JobDao {
	public void AddJob(Job job);
	public List<Job> FindJob();
	public List<Job> InfoJob(String id);
	public void DeleteJob(String no);
	public void UpdateJob(Job job);
}