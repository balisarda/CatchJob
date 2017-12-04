package com.care.CatchJob.IDAO;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.json.simple.JSONObject;

import com.care.CatchJob.DTO.*;

public interface subMemberDao {
	public void record(Record record);
	public void license(License license);
	public void empinfo(Empinfo empinfo);
	public List<HashMap<String, Object>> loadInfo_record(String nickname);
	public List<HashMap<String, Object>> loadInfo_license(String nickname);
	public List<HashMap<String, Object>> loadInfo_empinfo(String nickname);
	public void deleteRecord(HashMap<String, Object> map);
	public void deleteLicense(HashMap<String, Object> map);
	public void deleteEmpinfo(HashMap<String, Object> map);
}
