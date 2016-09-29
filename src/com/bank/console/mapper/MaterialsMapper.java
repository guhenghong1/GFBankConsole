package com.bank.console.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bank.console.resource.form.MaterialsForm;
import com.bank.console.resource.vo.MaterialsVO;

@Repository
public interface MaterialsMapper {
	//新增文件
	int addMaterials(MaterialsForm form);
	
	//修改文件
	int updateMaterials(MaterialsForm form);
	
	//删除文件
	int deleteMaterials(String companyId);
	
	//获取文件详情
	MaterialsVO getMaterialsInfo(String companyId);
	
	//查询列表
	List<MaterialsVO> getMaterialsList(MaterialsForm form);
	
	//查询数量
	int getMaterialsSum(MaterialsForm form);
	
	List<MaterialsVO> getAllMaterialsList();
}
