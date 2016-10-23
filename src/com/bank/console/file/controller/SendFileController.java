package com.bank.console.file.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bank.console.common.Constant;
import com.bank.console.common.PageCalc;
import com.bank.console.common.Pager;
import com.bank.console.common.interceptor.Permission;
import com.bank.console.common.util.DateUtil;
import com.bank.console.common.util.ResultUtil;
import com.bank.console.file.form.SendFileForm;
import com.bank.console.file.service.SendFileService;
import com.bank.console.file.vo.SendFileVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/sendFile")
public class SendFileController {
	@Autowired
	private SendFileService sendFileService;

	/**
	 * 跳转页面
	 * 
	 * @return
	 */
	@Permission
	@RequestMapping("/init")
	public String init() {
		return "file/sendFile";
	}

	/**
	 * 新增文件
	 * 
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping(value = "/addFile", method = RequestMethod.POST)
	@ResponseBody
	public String addFile(@ModelAttribute("sendFileForm") SendFileForm form) {
		// MultipartFile
		ResultUtil result = new ResultUtil();
		int res = 0;
		try {
			Date createDate = DateUtil.defaultStrToDate(form.getCreateDateStr());
			if(createDate != null) {
				form.setCreateDate(createDate);
			}
			
			res = sendFileService.addFile(form);
			int code = res >= 1 ? Constant.SUCCESS_CODE : Constant.ERROR_CODE;
			result.setCode(code);
			result.setMsg(res >= 1 ? Constant.SUCCESS_MSG : Constant.ERROR_MSG);
		} catch (Exception e) {
			result.setCode(Constant.ERROR_CODE);
			result.setMsg(Constant.ERROR_MSG);
			e.printStackTrace();
		}

		return JSONObject.fromObject(result).toString();
	}

	/**
	 * 修改文件
	 * 
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping(value = "/updateFile", method = RequestMethod.POST)
	@ResponseBody
	public String updateFile(@ModelAttribute("msendFileForm") SendFileForm form) {
		// MultipartFile
		ResultUtil result = new ResultUtil();
		int res = 0;
		try {
			Date createDate = DateUtil.defaultStrToDate(form.getCreateDateStr());
			if(createDate != null) {
				form.setCreateDate(createDate);
			}
			
			res = sendFileService.updateFile(form);
			int code = res >= 1 ? Constant.SUCCESS_CODE : Constant.ERROR_CODE;
			result.setCode(code);
			result.setMsg(res >= 1 ? Constant.SUCCESS_MSG : Constant.ERROR_MSG);
		} catch (Exception e) {
			result.setCode(Constant.ERROR_CODE);
			result.setMsg(Constant.ERROR_MSG);
			e.printStackTrace();
		}

		return JSONObject.fromObject(result).toString();
	}

	/**
	 * 获取文件列表
	 * 
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/getFileList")
	@ResponseBody
	public String getFileList(@RequestParam(value = "fileId") String fileId,
			@RequestParam(value = "keyWords") String keyWords, @RequestParam(value = "deptId") String deptId,
			@RequestParam(value = "pageNum", defaultValue = "1") String pageNum,
			@RequestParam(value = "pageSize", defaultValue = "10") String pageSize) {
		SendFileForm form = new SendFileForm();
		form.setFileId(fileId);
		form.setKeyWords(keyWords);
		form.setDeptId(deptId);

		int total = sendFileService.getFileSum(form);

		PageCalc calc = new PageCalc(total);
		form.setStartRow(calc.getStart(Integer.parseInt(pageNum)));
		form.setEndRow(calc.getEnd(Integer.parseInt(pageNum)));

		List<SendFileVO> fileList = sendFileService.getFileList(form);
		JSONArray jsonArr = new JSONArray();
		jsonArr = JSONArray.fromObject(fileList);

		Pager pager = new Pager();
		pager.setTotal(total);
		pager.setRows(jsonArr);
		return JSONObject.fromObject(pager).toString();
	}

	/**
	 * 获取文件列表
	 * 
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/queryFile")
	@ResponseBody
	public String queryFile(@ModelAttribute("qSendFileForm") SendFileForm form) {
		int total = sendFileService.getFileSum(form);

		List<SendFileVO> fileList = sendFileService.getFileList(form);
		JSONArray jsonArr = new JSONArray();
		jsonArr = JSONArray.fromObject(fileList);

		Pager pager = new Pager();
		pager.setTotal(total);
		pager.setRows(jsonArr);
		return JSONObject.fromObject(pager).toString();
	}

	/**
	 * 获取文件详情
	 * 
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/getFileInfo")
	@ResponseBody
	public String getFileInfo(@RequestParam("fileId") String fileId) {
		ResultUtil result = new ResultUtil();
		SendFileVO sendFile = sendFileService.getFileInfo(fileId);

		result.setCode(Constant.SUCCESS_CODE);
		result.setMsg(Constant.SUCCESS_MSG);
		result.setObj(sendFile);
		return JSONObject.fromObject(result).toString();
	}

	/**
	 * 获取文件详情
	 * 
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/deleteFile")
	@ResponseBody
	public String deleteFile(@RequestParam("fileId") String fileId) {
		ResultUtil result = new ResultUtil();
		int res = sendFileService.deleteFile(fileId);

		result.setCode(res > 0 ? Constant.SUCCESS_CODE : Constant.ERROR_CODE);
		result.setMsg(res > 0 ? Constant.SUCCESS_MSG : Constant.ERROR_MSG);
		return JSONObject.fromObject(result).toString();
	}

	/**
	 * 获取文件
	 * 
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/findFile")
	@ResponseBody
	public String findFile(@RequestParam("fileId") String fileId, HttpServletResponse resp) {
		resp.setHeader("content-type", "application/msword;charset=UTF-8");
		SendFileVO file = sendFileService.getFileInfo(fileId);
		return file.getAttachment();
	}
}
