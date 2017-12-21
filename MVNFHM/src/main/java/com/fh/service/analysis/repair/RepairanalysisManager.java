package com.fh.service.analysis.repair;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

public interface RepairanalysisManager {
	
	/**获取维修列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**获取待维修网关
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> listGateway(Page page)throws Exception;
	
	/**获取可替换网关
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> listRepairableGateway(Page page)throws Exception;
	
	/**更新网关状态
	 * @param page
	 * @throws Exception
	 */
	public void updateGatewayStatus(PageData pd)throws Exception;
	
	/**获取旧网关的节点信息
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> getOldClientNodeAdress(PageData pd)throws Exception;
	
	/**更换网关
	 * @param pd PageData
	 * @throws Exception
	 */
	public List<PageData> updateGateway(PageData pd)throws Exception;
	
	/**用新网关id更新旧网关id
	 * @param page
	 * @throws Exception
	 */
	public void updateOldGatewayId(PageData pd)throws Exception;
	
	/**获取分组节点信息
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> getTermInfo(PageData pd)throws Exception;
	
	/**获取策略信息
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> getStrategyInfo(PageData pd)throws Exception;
	
	/**用新网关id更新分组表旧网关id
	 * @param page
	 * @throws Exception
	 */
	public void updateOldTermGatewayId(PageData pd)throws Exception;
	
	
	/**用新网关id更新策略表旧网关id
	 * @param page
	 * @throws Exception
	 */
	public void updateOldStrategyGatewayId(PageData pd)throws Exception;
	
	/**获取策略信息
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> getGatewayTermInfo(PageData pd)throws Exception;
	
	/**按下完成按钮动作
	 * @param page
	 * @throws Exception
	 */
	public void updateCompleteInfo(PageData pd)throws Exception;
	
	/**按下撤销按钮动作
	 * @param page
	 * @throws Exception
	 */
	public void updateCancelInfo(PageData pd)throws Exception;
	
}
