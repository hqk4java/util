package com.bz.mh.visit.dao;

import java.io.Serializable;

import org.springframework.stereotype.Repository;

import com.bz.mh.model.common.BaseDao;
import com.bz.mh.po.VisitLog;
@Repository
public class VisitLogDao extends BaseDao<VisitLog, Serializable> {

	public void print() {
		System.out.println("进来了！");
	}
	
	public Integer doQueryVisitCount(int type) {
		String sql = "select COUNT(DISTINCT visit_ipaddress) FROM VISIT_LOG";
		if (type == 2){
			sql = "select COUNT(visit_ipaddress) FROM VISIT_LOG";
		}
		Integer count = getCountBySql(sql, null);
		return count;
	}
}
