package com.bank.console.common;

public class PageCalc {

	/** 记录总数 */
    private Integer totalCount;
    /** 每页数量 */
    private Integer pageSize;
    /** 页码总数 */
    private Integer pageCount;
    
    public PageCalc(Integer totalCount, Integer pageSize){
        this.totalCount = totalCount;
        this.pageSize = pageSize;
        this.pageCount = totalCount / pageSize + (totalCount % pageSize > 0 ? 1 : 0);
    }

    public PageCalc(Integer totalCount){
        this.totalCount = totalCount;
        this.pageSize = ConfigProperty.LIST_PAGE_SIZE;
        this.pageCount = totalCount / pageSize + (totalCount % pageSize > 0 ? 1 : 0);
    }

    /**
     * 根据页码计算记录起始位置
     * @param page 页码
     * @return 记录起始位置
     */
    public int getStart(Integer pageNum){
    	if(pageNum > this.getPageCount()){
    		pageNum = this.getPageCount();
    	}
    	if(pageNum == 0) {
    		return 0;
    	}
        return (pageNum * this.getPageSize()) - this.getPageSize();
    }

    /**
     * 根据页码计算记录结束位置
     * @param page 页码
     * @return 记录结束位置
     */
    public Integer getEnd(Integer pageNum){
    	if(pageNum > this.getPageCount()){
    		pageNum = this.getPageCount();
    	}
        return pageNum * this.getPageSize();
    }

    public Integer getTotalCount(){
        return totalCount;
    }

    public Integer getPageCount(){
        return pageCount;
    }

    public Integer getPageSize(){
        return pageSize;
    }
}
