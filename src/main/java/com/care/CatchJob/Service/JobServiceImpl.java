package com.care.CatchJob.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.care.CatchJob.DTO.Apply;
import com.care.CatchJob.IDAO.JobDao;
import com.care.CatchJob.IService.JobService;

@Service
public class JobServiceImpl implements JobService {
@Autowired
private JobDao jobdao;

@Override
public String getApplyId(Apply apply) {
	String memberNo=jobdao.chkDuplicate(apply);
	if(memberNo.equals("0")||memberNo.equals(null)) {return "possible";		
 	}
	return "impossible";
}
}
