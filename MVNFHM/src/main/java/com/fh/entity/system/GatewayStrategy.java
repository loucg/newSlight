package com.fh.entity.system;
/**
 * 
* 类名称：策略网关控制分组对应
* 类描述： 
* @author wap
* 作者单位： 
* 联系方式：
* 修改时间：2017年7月25日
* @version 1.0
 */
public class GatewayStrategy {

	private String strategy_gatewayterm_id;		//策略与网关控制组对应ID
	private String strategy_id;		//策略ID
	private String gateway_term_id;		//网关控制分组ID
	private String gateway_id;			//网关ID
	private String gateway_strategy;	//策略序列号
	private String gateway_team_id;		//网关控制分组
	
	public String getStrategy_gatewayterm_id() {
		return strategy_gatewayterm_id;
	}
	public void setStrategy_gatewayterm_id(String strategy_gatewayterm_id) {
		this.strategy_gatewayterm_id = strategy_gatewayterm_id;
	}
	public String getStrategy_id() {
		return strategy_id;
	}
	public void setStrategy_id(String strategy_id) {
		this.strategy_id = strategy_id;
	}
	public String getGateway_id(){
		return gateway_id;
	}
	public void setGateway_id(String gateway_id){
		this.gateway_id = gateway_id;
	}
	public String getGateway_strategy(){
		return gateway_strategy;
	}
	public void setGateway_strategy(String gateway_strategy){
		this.gateway_strategy = gateway_strategy;
	}
	public String getGateway_term_id(){
		return gateway_term_id;
	}
	public void setGateway_term_id(String gateway_term_id){
		this.gateway_term_id = gateway_term_id;
	}
	public String getGateway_team_id(){
		return gateway_team_id;
	}
	public void setGateway_team_id(String gateway_team_id){
		this.gateway_team_id = gateway_team_id;
	}
}