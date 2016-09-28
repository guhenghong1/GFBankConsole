package com.bank.console.resource.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bank.console.mapper.MaterialsMapper;
import com.bank.console.resource.form.MaterialsForm;
import com.bank.console.resource.vo.MaterialsVO;

@Service
public class MaterialsService {
	@Autowired
	private MaterialsMapper materialsMapper;
	
	
	/**
	 * 新增文件
	 * @param Materials
	 * @return
	 * @throws Exception 
	 */
	public int addMaterials(MaterialsForm form) throws Exception {
		return materialsMapper.addMaterials(form);
	}
	
	/**
	 * 修改文件
	 * @param Materials
	 * @return
	 */
	public int updateMaterials(MaterialsForm form) {
		return materialsMapper.updateMaterials(form);
	}
	
	/**
	 * 删除文件
	 * @param MaterialsId
	 * @return
	 */
	public int deleteMaterials(String companyId) {
		return materialsMapper.deleteMaterials(companyId);
	}

	/**
	 * 获取文件列表
	 * @param Materials
	 * @return
	 */
	public List<MaterialsVO> getMaterialsList(MaterialsForm Materials) {
		return materialsMapper.getMaterialsList(Materials);
	}
	
	/**
	 * 获取文件详情
	 * @param Materials
	 * @return
	 */
	public MaterialsVO getMaterialsInfo(String companyId) {
		return materialsMapper.getMaterialsInfo(companyId);
	}
	
	/**
	 * 获取数量
	 * @param Materials
	 * @return
	 */
	public int getMaterialsSum(MaterialsForm form) {
		return materialsMapper.getMaterialsSum(form);
	}
}
