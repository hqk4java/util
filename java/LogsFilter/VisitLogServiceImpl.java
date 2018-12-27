package com.bz.mh.visit.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bz.mh.po.VisitLog;
import com.bz.mh.service.common.BaseService;
import com.bz.mh.visit.dao.VisitLogDao;
import com.bz.mh.visit.service.VisitLogService;

@Service
public class VisitLogServiceImpl extends BaseService implements VisitLogService {

	@Autowired
	private VisitLogDao visitLogDao;
	@Override
	public Integer doQueryVisitCount(int type) {
		return visitLogDao.doQueryVisitCount(type);
	}
	
	@Override
	public void doSave(VisitLog visitLog) {
		 visitLogDao.save(visitLog);
	}

}
