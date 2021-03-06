/**
 * Copyright &copy; 2016-2020 <a href="http://www.javafast.cn">JavaFast</a> All rights reserved.
 */
package com.javafast.modules.om.dao;

import org.hibernate.validator.constraints.Length;
import java.math.BigDecimal;
import com.javafast.modules.sys.entity.User;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.List;
import com.google.common.collect.Lists;

import java.util.List;
import com.javafast.common.persistence.CrudDao;
import com.javafast.common.persistence.annotation.MyBatisDao;
import com.javafast.modules.om.entity.OmOrder;

/**
 * 销售订单DAO接口
 * @author javafast
 * @version 2017-07-14
 */
@MyBatisDao
public interface OmOrderDao extends CrudDao<OmOrder> {
	
}