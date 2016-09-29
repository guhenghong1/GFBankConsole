package com.bank.console.test.customer;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.bank.console.common.util.DateUtil;
import com.bank.console.equipment.model.Equipment;
import com.bank.console.equipment.vo.EquipmentVo;
import com.bank.console.mapper.EquipmentMapper;

/**
 * 
 * @author zhouzhongxing
 * @since 2016年9月29日
 *
 */
@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"classpath:spring-mybatis.xml"})
@TransactionConfiguration(transactionManager="transactionManager",defaultRollback=false)
@Transactional
public class EquipmentMapperTest {
	
	@Resource
	private EquipmentMapper equipmentMapper;
	
	@Test
	public void testSave(){
		Equipment equipment = new Equipment();
		equipment.setId("11");
		equipment.setName("设备11");
		equipment.setType("型号1");
		equipment.setLocation("行政部办公室1");
		equipment.setInUse(1);
		equipment.setCompanyId("666661");
		equipment.setBuyTime(new Date());
		equipment.setPrice("4561");
		equipment.setDeptId("12221");
		equipment.setRemark("备注");
		equipmentMapper.addEquipment(equipment);
	}
	
	@Test
	public void testUpdate(){
		Equipment equipment = equipmentMapper.getEquipmentInfo("1");
		equipment.setName("设备修改");
		equipment.setType("型号1修改");
		equipment.setLocation("行政部办公室1修改");
		equipment.setInUse(0);
		equipment.setCompanyId("666661修改");
		equipment.setBuyTime(DateUtil.defaultStrToDate("2016-06-01 15:22:22"));
		equipment.setPrice("12345");
		equipment.setDeptId("1");
		equipment.setRemark("备注修改");
		equipmentMapper.updateEquipment(equipment);
	}
	
	@Test
	public void testDelete(){
		equipmentMapper.deleteEquipment("11");
	}
	
	@Test
	public void testGetEquipmentList(){
		Map<String, Object>  param = new HashMap<String, Object>();
		//param.put("name", "1");
		param.put("startRow", 0);
		param.put("endRow", 10);
		List<EquipmentVo> list = equipmentMapper.getEquipmentList(param);
		for(EquipmentVo equipment : list){
			System.out.println(equipment.getName());
		}
	}
	
	@Test
	public void testGetEquipmentSum(){
		Map<String, Object>  param = new HashMap<String, Object>();
		//param.put("name", "1");
		param.put("startRow", 0);
		param.put("endRow", 10);
		int count = equipmentMapper.getEquipmentSum(param);
		System.out.println("记录数：" + count);
	}

}
