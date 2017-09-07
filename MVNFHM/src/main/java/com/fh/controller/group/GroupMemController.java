package com.fh.controller.group;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.group.GroupService;
import com.fh.service.group.mem.GroupMemService;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;

/**
 * 分组设置
 * @author xiaozhou
 * 创建时间：2017年2月5日groupmem/listMems.do?id=1
 */
@Controller
@RequestMapping(value="/groupmem")
public class GroupMemController extends BaseController{

	String menuUrl = "groupmem/listMems.do";		//页面配置的菜单地址
    @Resource(name="groupMemService")
    private GroupMemService groupMemService;
    @Resource(name="groupService")
    private GroupService groupService;
    @Resource(name="departmentService")
    private DepartmentManager departmentService;
	
	/**
	 * 显示已分组列表
	 * @param page
	 * @return
	 */
	@RequestMapping("/listMems")
	public ModelAndView listMems(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		PageData termforpage = new PageData();
		pd = this.getPageData();
		//System.out.println(pd.getString("id")+pd.getString("name")+"-------------------------------------");
		String location = pd.getString("location");			//检索条件：位置
		if(null !=location && !"".equals(location)){
			pd.put("location", location.trim());
		}
		String clientname = pd.getString("clientname");		//检索条件：终端名称
		if(null !=clientname && !"".equals(clientname)){
			pd.put("clientname", clientname.trim());
		}
		String lamp_pole_num = pd.getString("lamp_pole_num");		//检索条件：灯杆号
		if(null !=lamp_pole_num && !"".equals(lamp_pole_num)){
			pd.put("lamp_pole_num", lamp_pole_num.trim());
		}
		String client_code = pd.getString("client_code");		//检索条件：终端号
		if(null !=client_code && !"".equals(client_code)){
			pd.put("client_code", client_code.trim());
		}
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		//String title = pd.getString("title");
		
		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		
		page.setPd(pd);
		termforpage = groupService.findById(pd);
		List<PageData> groupMem = groupMemService.listMem(page);	//获取列表
		mv.setViewName("groupmanage/groupmember_list");
		
		/*if("chakan".equals(title)){
			mv.setViewName("groupmanage/groupmember_view");
		}else if("tishan".equals(title)){
			mv.setViewName("groupmanage/groupmember_list");
		}*/
		mv.addObject("groupMem", groupMem);
		mv.addObject("pd", pd);
		mv.addObject("termforpage", termforpage);
		mv.addObject("QX", Jurisdiction.getHC());
		
		return mv;
	}
	
	/**
	 * 显示未分组列表
	 * @param page
	 * @return
	 */
	@RequestMapping("/listOthers")
	public ModelAndView listOthers(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		PageData termforpage = new PageData();
		pd = this.getPageData();
		//System.out.println(pd.getString("id")+pd.getString("name")+"-------------------------------------");
	
		String location = pd.getString("location");			//检索条件：位置
		if(null !=location && !"".equals(location)){
			pd.put("location", location.trim());
		}
		String clientname = pd.getString("clientname");		//检索条件：终端名称
		if(null !=clientname && !"".equals(clientname)){
			pd.put("clientname", clientname.trim());
		}
		String lamp_pole_num = pd.getString("lamp_pole_num");		//检索条件：灯杆号
		if(null !=lamp_pole_num && !"".equals(lamp_pole_num)){
			pd.put("lamp_pole_num", lamp_pole_num.trim());
		}
		String client_code = pd.getString("client_code");		//检索条件：终端号
		if(null !=client_code && !"".equals(client_code)){
			pd.put("client_code", client_code.trim());
		}
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		
		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		
		page.setPd(pd);
		termforpage = groupService.findById(pd);
		List<PageData> groupOther = groupMemService.listOthers(page);	//获取列表
		mv.setViewName("groupmanage/groupother_list");
		mv.addObject("groupOther", groupOther);
		mv.addObject("pd", pd);
		mv.addObject("termforpage", termforpage);
		mv.addObject("QX", Jurisdiction.getHC());
		
		return mv;
	}
	
	/**
	 * 批量添加成员
	 */
	@RequestMapping("/addMems")
	@ResponseBody
	public Object addMems() throws Exception{
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		List<PageData> secondSeachGT = new ArrayList<PageData>();
		String[] thirdSeachGT = new String[16];
 		List<PageData> thirdSeachGT2 = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		String DATA_IDS1 = pd.getString("DATA_IDS1");
//	            待开发。。。。。
		/*pd.put("DATA_IDS", DATA_IDS);
		List ms = groupMemService.addMember(pd);*/
		
		
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		pd.put("comment","添加成员");
		pd.put("b_log_type_id", 6);
		pd.put("tdate", new Date());//创建时间
		//添加cmd命令内容1
		groupMemService.addCmdContent(pd);
		
		pd.put("b_cmd_type_id",3);
		pd.put("status",1);
		//获取b_user_log的id
		Integer b_user_log_id = groupMemService.searchUserLogId(pd);
		pd.put("b_user_log_id", b_user_log_id);
		System.out.println("==============用户日志id============="+pd.get("b_user_log_id"));

		
		System.out.println(DATA_IDS +"----------------------------------------");
		System.out.println(DATA_IDS1 +"----------------------------------------");
		
		String c_term_id = pd.getString("id");
		pd.put("c_term_id", c_term_id);
		if(null !=DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			String ArrayDATA_IDS1[] = DATA_IDS1.split(",");

			for(int i=0;i<ArrayDATA_IDS.length;i++){
				pd.put("c_client_id", ArrayDATA_IDS[i]);
				//pd.put("c_gateway_id", ArrayDATA_IDS1[i]);
				groupMemService.addMember(pd);
				pd.put("msg", "ok");
			}
			for(int i=0;i<ArrayDATA_IDS1.length;i++){
				//pd.put("c_client_id", ArrayDATA_IDS[i]);
				pd.put("c_gateway_id", ArrayDATA_IDS1[i]);
				//根据组id和网关id查找相同的结果
				//当前选择终端对应的网关控制分组,如果有直接添加，无则生成
				List<PageData> firstSeachGT = groupMemService.getGTList(pd);
				System.out.println(firstSeachGT+"==============网关控制分组==============");
				//System.out.println(firstSeachGT.get(0)+"=================120===========");
				//第一步
				if(firstSeachGT !=null && firstSeachGT.size() !=0){
					pd.put("c_gateway_team_id", firstSeachGT.get(0));
					for(int n=0;n<ArrayDATA_IDS.length;n++){
						pd.put("c_client_id_last", ArrayDATA_IDS[n]);
						//解决多重循环的麻烦
						Integer C_id_Count =  groupMemService.solveProblemMember(pd);
						if(C_id_Count !=0 ){
//							System.out.println(pd+"===============0000011为null============");
							groupMemService.addMemberAssistFirst(pd);  
						}
					}

					//第二个参数（数量）
					Integer one001 = groupMemService.searchsecond(pd);
					pd.put("ONE", one001);
					System.out.println(pd.get("ONE")+"===============选择的此网关下终端数============");
					
					//第一个参数（网组号）
					Integer one002 = groupMemService.searchfirst(pd);
					pd.put("TWO", one002);
					System.out.println(pd.get("TWO")+"==============网关控制分组号=============");
					
					if(one001>100){
						pd.put("TEN", one001-100);
						System.out.println(one001+"===============233为null============");
						//第三个参数
						String one003 = groupMemService.searchthird(pd);
						String sb = "";
						String sb2 = "";
						String ArrayDATA_STR[] =one003.split("、");
						 
						for( int b = 0; b < 100; b++ )
						{
//						    sb.append(ArrayDATA_STR[b]).append("、 ");
							sb = sb + ArrayDATA_STR[b] +"、";  
						    //System.out.println(sb.length());
						}
						sb = sb.substring(0,sb.length() - 1);
						 
						for( int p = 100; p < ArrayDATA_STR.length; p++ )
						{
							sb2 = sb2 + ArrayDATA_STR[p] +"、"; 
						}
						sb2 = sb2.substring(0,sb2.length()-1);
//						System.out.println(ArrayDATA_STR.length+"===============1111111111111111111111111111111为null============");
//						System.out.println(sb2.toString()+"===============1111111111111111111111111111111为null============");
//						System.out.println(sb.toString()+"===============255为null============");
						
						pd.put("THREE", one003);
						pd.put("FOUR", sb.toString());
						pd.put("FIVE", sb2.toString());
//						System.out.println(pd.get("THREE")+"===============260为null============");
//						System.out.println(pd.get("FOUR")+"===============261为null============");
//						System.out.println(pd.get("FIVE")+"===============262为null============");
						
						pd.put("cmd", pd.get("ONE")+","+"0"+","+"100"+","+pd.get("TWO")+","+pd.get("FOUR"));
						pd.put("cmd1", pd.get("ONE")+","+"100"+","+pd.get("TEN")+","+pd.get("TWO")+","+pd.get("FIVE"));
						
//						System.out.println(pd.get("cmd")+"===============267为null============");
//						System.out.println(pd.get("cmd1")+"===============268为null============");
						////插入最后一张命令表
						groupMemService.finallypage(pd);
						groupMemService.finallypagelast(pd);
						pd.put("msg", "ok");
						
					}
					else {//总节点个数小于等于100时
						//第三个参数
						String one003 = groupMemService.searchthird(pd);
						pd.put("THREE", one003);
//						System.out.println(pd.get("THREE")+"===============279为null============");
						pd.put("cmd", pd.get("ONE")+","+"0"+","+pd.get("ONE")+","+pd.get("TWO")+","+pd.get("THREE"));
//						System.out.println(pd.get("cmd")+"===============281为null============");
						//插入最后一张命令表
						groupMemService.finallypage(pd);
						pd.put("msg", "ok");
					}
				}
				else{
					//根据网关id查找相同网关id对应的网关控制分组id（最后一个id）
					secondSeachGT = groupMemService.getSGTList(pd);
					PageData SGT	= secondSeachGT.get(0);
//					System.out.println( secondSeachGT+"===============mxcmxcxxxxxx============");
//					System.out.println( SGT+"===============003============");
					//System.out.println(secondSeachGT.get(0).get("c_gateway_team_id")+"===============004============");	
					//System.out.println(secondSeachGT+"===============004============");
					//第二步
						 if( null==SGT){
//							 System.out.println("===============0031为null============");
								pd.put("c_gateway_team_id", 1);
								groupMemService.addMemberAssist(pd);
//								System.out.println(pd+"===============0032为null============");
								//接下来就是往最后一张表里面加数据了。1.现根据上面的DATA_IDS取终端；2.向最后一张表里插入获取到的数据
								for(int n=0;n<ArrayDATA_IDS.length;n++){
									pd.put("c_client_id_last", ArrayDATA_IDS[n]);
									//解决多重循环的麻烦
									Integer C_id_Count =  groupMemService.solveProblemMember(pd);
									if(C_id_Count !=0 ){
//										System.out.println(pd+"===============0033为null============");
										groupMemService.addMemberAssistFirst(pd);  
									} 
								}
								
								//分组批次(这个方法太繁琐)
							/*	int shulian = ArrayDATA_IDS.length;
								System.out.println(shulian+"===============2222为null============");
								int shulianzushu = ArrayDATA_IDS.length/100;
								System.out.println(shulianzushu+"===============2221为null============");
								for(int k=0;k<shulianzushu+1;k++){
									if(k<shulianzushu){
										for(int j=0;j<100;j++){
											System.out.println(ArrayDATA_IDS[k*100+j]+"===============zhangsang为null============");
										}
									}
									else {
										for(int j=0;j<shulian-k*100;j++){
											System.out.println(ArrayDATA_IDS[k*100+j]+"===============zhang 为null============");
											System.out.println(pd+"===============lalalal 为null============");
										}
									}
 								
								}*/
								
								
								//第二个参数（数量）
								Integer one001 = groupMemService.searchsecond(pd);
								pd.put("ONE", one001);
//								System.out.println(pd.get("ONE")+"===============0018为null============");
								
								//第一个参数（网组号）
								Integer one002 = groupMemService.searchfirst(pd);
								pd.put("TWO", one002);
//								System.out.println(pd.get("TWO")+"===============0017为null============");
								
								/*String one003 = groupMemService.searchthird(pd);
								String ArrayDATA_STR[] =one003.split("、");
								System.out.println(one003.length()+"===============346为null============");
								for(int b = 0; b < ArrayDATA_STR.length; b++){
									System.out.println(ArrayDATA_STR[b]+"===============346为null============");
								}*/
								if(one001>100){
									pd.put("TEN", one001-100);
//									System.out.println(one001+"===============0036363636363636为null============");
									//第三个参数
									String one003 = groupMemService.searchthird(pd);
									String sb = "";
									String sb2 = "";
									String ArrayDATA_STR[] =one003.split("、");
									 
									for( int b = 0; b < 100; b++ )
									{
//									    sb.append(ArrayDATA_STR[b]).append("、 ");
										sb = sb + ArrayDATA_STR[b] +"、";  
									    //System.out.println(sb.length());
									}
									sb = sb.substring(0,sb.length() - 1);
									 
									for( int p = 100; p < ArrayDATA_STR.length; p++ )
									{
										sb2 = sb2 + ArrayDATA_STR[p] +"、"; 
									}
									sb2 = sb2.substring(0,sb2.length()-1);
//									System.out.println(ArrayDATA_STR.length+"===============2222222222222222为null============");
									
//									System.out.println(sb2.toString()+"===============222222222222222222222为null============");
//									System.out.println(sb.toString()+"===============00258258258666612为null============");
									
									pd.put("THREE", one003);
									pd.put("FOUR", sb.toString());
									pd.put("FIVE", sb2.toString());
//									System.out.println(pd.get("THREE")+"===============6666661119为null============");
//									System.out.println(pd.get("FOUR")+"===============6666661118为null============");
//									System.out.println(pd.get("FIVE")+"===============6666661114000为null============");
									
									pd.put("cmd", pd.get("ONE")+","+"1"+","+"100"+","+pd.get("TWO")+","+pd.get("FOUR"));
									pd.put("cmd1", pd.get("ONE")+","+"101"+","+pd.get("TEN")+","+pd.get("TWO")+","+pd.get("FIVE"));
									
									System.out.println(pd.get("cmd")+"===============0016为null============");
									System.out.println(pd.get("cmd1")+"===============00161为null============");
									////插入最后一张命令表
									groupMemService.finallypage(pd);
									groupMemService.finallypagelast(pd);
									pd.put("msg", "ok");
									
								}
								else {
									//第三个参数
									String one003 = groupMemService.searchthird(pd);
									pd.put("THREE", one003);
									System.out.println(pd.get("THREE")+"===============6666661113为null============");
									pd.put("cmd", pd.get("ONE")+","+"1"+","+pd.get("ONE")+","+pd.get("TWO")+","+pd.get("THREE"));
									System.out.println(pd.get("cmd")+"===============001666666为null============");
									////插入最后一张命令表
									groupMemService.finallypage(pd);
									pd.put("msg", "ok");
								}
								
						  }
						else {
							//先定义一个空数组
							//List fourSearch = new ArrayList();
							//取出分组数据的总数
							Integer SGT2 = groupMemService.getSGTListcount(pd);
							System.out.println(SGT2+"===============0041不为null============");
							
							//取出所有的数据
							thirdSeachGT2 = groupMemService.getSGTListAll(pd);
								System.out.println("==="+thirdSeachGT2.size());
								for (int j = 0; j < thirdSeachGT2.size(); j++) {
									System.out.println("------"+((int) thirdSeachGT2.get(j).get("c_gateway_team_id")-1));
									thirdSeachGT[((int) thirdSeachGT2.get(j).get("c_gateway_team_id")-1)] = thirdSeachGT2.get(j).get("c_gateway_team_id").toString();
									System.out.println("第"+(j+1)+"---次网关控制分组号为:"+thirdSeachGT[((int) thirdSeachGT2.get(j).get("c_gateway_team_id")-1)]);
//									System.out.println("第"+(j+1)+"---次网关控制分组号为:"+thirdSeachGT[(int) thirdSeachGT2.get(j).get("c_gateway_team_id")]);
									
									
//									for (int a = 0; a < ArrayDATA_IDS1.length; a++) {
//										
//										if () {
//											
//										}
//										thirdSeachGT[j] = thirdSeachGT2;
//										
//										System.out.println("===============0042不为null============");
//									}
								}
							
							System.out.println(thirdSeachGT[0]+"---"+thirdSeachGT[1]+"---"+thirdSeachGT[2]+"---"+thirdSeachGT[3]+"---"+thirdSeachGT[4]+"---"+thirdSeachGT[5]+"===============0043不为null============");
							//取出最大网关分组号
							Integer SGT1 = (Integer) secondSeachGT.get(0).get("c_gateway_team_id");
							System.out.println(SGT1+"===============0044不为null============");
							if(SGT1<16){
								if(SGT1==SGT2){
									SGT1=SGT1+1;
									pd.put("c_gateway_team_id", SGT1);
								}
								else{
//									for(int k=0;k<SGT2;k++){
									//循环补充网关控制分组号
									for(int k=0;k<16;k++){
										if (thirdSeachGT[k]!=null) {
											
										}else {
											
											pd.put("c_gateway_team_id", k+1);
											break;
										}
										
//										int a = Integer.parseInt(thirdSeachGT[k]);
//										int b = Integer.parseInt(thirdSeachGT[k+1]);
////										Integer a = (Integer) thirdSeachGT.get(k).get("c_gateway_team_id");
////										Integer b = (Integer) thirdSeachGT.get(k+1).get("c_gateway_team_id");
//										if(b-a>1){
//											pd.put("c_gateway_team_id", k+1);
//											break;
//										}
//										else{
//											pd.put("c_gateway_team_id", 1);
//											break;
//										}
										
									}
								}
								
								 groupMemService.addMemberAssist(pd);
								//接下来就是往最后一张表里面加数据了
								 for(int n=0;n<ArrayDATA_IDS.length;n++){
										pd.put("c_client_id_last", ArrayDATA_IDS[n]);
										//解决多重循环的麻烦
										Integer C_id_Count =  groupMemService.solveProblemMember(pd);
										if(C_id_Count !=0 ){
											System.out.println(pd+"===============0041为null============");
											groupMemService.addMemberAssistFirst(pd);  
										}
								  }
								 
								 
									//第二个参数（数量）
									Integer one001 = groupMemService.searchsecond(pd);
									pd.put("ONE", one001);
									System.out.println(pd.get("ONE")+"===============0018为null============");
									
									//第一个参数（网组号）
									Integer one002 = groupMemService.searchfirst(pd);
									pd.put("TWO", one002);
									System.out.println(pd.get("TWO")+"===============0017为null============");
									/*String one003 = groupMemService.searchthird(pd);
									String ArrayDATA_STR[] =one003.split("、");
									for(int b = 0; b < one001; b++){
										System.out.println(ArrayDATA_STR[b]+"===============460为null============");
									}*/
									if(one001>100){
										pd.put("TEN", one001-100);
										System.out.println(one001+"===============460为null============");
										//第三个参数
										String one003 = groupMemService.searchthird(pd);
										String sb = "";
										String sb2 = "";
										String ArrayDATA_STR[] =one003.split("、");
										 
										for( int b = 0; b < 100; b++ )
										{
 
											sb = sb + ArrayDATA_STR[b] +"、";  
										   
										}
										sb = sb.substring(0,sb.length()-1);
										 
										for( int p = 100; p < ArrayDATA_STR.length; p++ )
										{
											sb2 = sb2 + ArrayDATA_STR[p] +"、"; 
										}
										sb2 = sb2.substring(0,sb2.length() - 1);
										System.out.println(ArrayDATA_STR.length+"===============3333333333333333333为null============");
										System.out.println(sb2.toString()+"===============3333333333333为null============");
									
										System.out.println(sb.toString()+"===============482为null============");
										
										pd.put("THREE", one003);
										pd.put("FOUR", sb.toString());
										pd.put("FIVE", sb2.toString());
										System.out.println(pd.get("THREE")+"===============487为null============");
										System.out.println(pd.get("FOUR")+"===============488为null============");
										System.out.println(pd.get("FIVE")+"===============489为null============");
										
										pd.put("cmd", pd.get("ONE")+","+"1"+","+"100"+","+pd.get("TWO")+","+pd.get("FOUR"));
										pd.put("cmd1", pd.get("ONE")+","+"101"+","+pd.get("TEN")+","+pd.get("TWO")+","+pd.get("FIVE"));
										
										System.out.println(pd.get("cmd")+"===============494为null============");
										System.out.println(pd.get("cmd1")+"===============495为null============");
										////插入最后一张命令表
										groupMemService.finallypage(pd);
										groupMemService.finallypagelast(pd);
										pd.put("msg", "ok");
										
									}
									else {
										//第三个参数
										String one003 = groupMemService.searchthird(pd);
										pd.put("THREE", one003);
										System.out.println(pd.get("THREE")+"===============506为null============");
										pd.put("cmd", pd.get("ONE")+","+"1"+","+pd.get("ONE")+","+pd.get("TWO")+","+pd.get("THREE"));
										System.out.println(pd.get("cmd")+"===============508为null============");
										////插入最后一张命令表
										groupMemService.finallypage(pd);
										pd.put("msg", "ok");
									}
									 
									
							 }
							 else{
								 pd.put("msg", "no");
							     }
						  } 
				  }
			}
			
		}
		else{
			pd.put("msg", "no");
			System.out.println("mei you shu ju ");
		   }
		
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	/**
	 * 批量踢删成员
	 */
	@RequestMapping("/removeMems")
	@ResponseBody
	public Object removeMems() throws Exception{
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		List<PageData> removeList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		pd.put("comment","踢除成员");
		pd.put("b_log_type_id", 6);
		pd.put("tdate", new Date());//创建时间
		//添加cmd命令内容1
		groupMemService.addCmdContent(pd);

		pd.put("b_cmd_type_id",3);
		pd.put("status",1);
		//获取b_user_log的id
		Integer b_user_log_id = groupMemService.searchUserLogId(pd);
		pd.put("b_user_log_id", b_user_log_id);
		
		String c_term_id = pd.getString("id");
		pd.put("c_term_id", c_term_id);
		if(null !=DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0;i<ArrayDATA_IDS.length;i++){
				pd.put("c_client_id", ArrayDATA_IDS[i]);
				groupMemService.removeMember(pd);
				
				System.out.println("===================="+pd.get("c_client_id"));
				Integer removeCGTID = groupMemService.searchRemoveMemberGT(pd);
				//System.out.println(removeList+"+++++++++++++++++000000009");
				//System.out.println(removeList.get(0).get("c_gateway_term_id")+"+++++++++++++++++0000000011");
				pd.put("c_gateway_term_id", removeCGTID);
				System.out.println(pd+"+++++++++++++++++11111111111111");
				
				
				//删除网组表里面的数据（最后一张表）
				groupMemService.removeMemberLast(pd);
				
				Integer Cgt_id_Count =  groupMemService.conutRemoveMember(pd);
				if(Cgt_id_Count==0){
					//删除倒数第二张表里面的网组id对应的那一行数据
					groupMemService.removeMemberContinueLast(pd);
				}
				pd.put("msg", "ok");
			}
		}else{
			pd.put("msg", "no");
			System.out.println("mei you shu ju ");
		}
		//往命令表里添加数据
		//第一个参数（网组号）
		System.out.println(pd+"===============2017为null============");
		removeList = groupMemService.getGatewayId(pd);
		System.out.println(removeList+"===============2018为null============");
		
		if( !removeList.isEmpty()){
			for(int i=0;i<removeList.size();i++){
				pd.put("CGID", removeList.get(i).get("c_gateway_id"));
				//第二个参数（数量）
				Integer two002 = groupMemService.searchdeletesecond(pd);
				
				pd.put("FOUR", two002);
				System.out.println(pd.get("FOUR")+"===============3333为null============");
				
				//第一个参数（网组号）
				Integer two001 = groupMemService.searchdeletefirst(pd);
				pd.put("FIVE", two001);
				System.out.println(pd.get("FIVE")+"===============2222为null============");
				
				
				
				
				if(two002>100){
					pd.put("TEN", two002-100);
					System.out.println(two002+"===============460为null============");
					//第三个参数
					String two003 = groupMemService.searchdeletethird(pd);
					pd.put("SIX", two003);
					System.out.println(pd.get("SIX")+"===============4444为null============");
				 
					String tsb = "";
					String tsb2 = "";
					String ArrayDATA_STR1[] =two003.split("、");
					 
					for( int b = 0; b < 100; b++ )
					{

						tsb = tsb + ArrayDATA_STR1[b] +"、";  
					   
					}
					tsb = tsb.substring(0,tsb.length()-1);
					 
					for( int p = 100; p < ArrayDATA_STR1.length; p++ )
					{
						tsb2 = tsb2 + ArrayDATA_STR1[p] +"、"; 
					}
					tsb2 = tsb2.substring(0,tsb2.length() - 1);
					System.out.println(ArrayDATA_STR1.length+"===============3333333333333333333为null============");
					System.out.println(tsb2.toString()+"===============3333333333333为null============");
				
					System.out.println(tsb.toString()+"===============482为null============");
					
					 
					pd.put("SEVEN", tsb.toString());
					pd.put("EIGHT", tsb2.toString());
					 
					System.out.println(pd.get("SEVEN")+"===============488为null============");
					System.out.println(pd.get("EIGHT")+"===============489为null============");
					pd.put("cmd", pd.get("FOUR")+","+"1"+","+"100"+","+pd.get("FIVE")+","+pd.get("SEVEN"));
					pd.put("cmd1", pd.get("FOUR")+","+"101"+","+pd.get("TEN")+","+pd.get("FIVE")+","+pd.get("EIGHT"));
					 
					System.out.println(pd.get("cmd")+"===============5555为null============");
					////插入最后一张命令表
					groupMemService.finallydeletepage(pd); 
					groupMemService.finallydeletepagelast(pd); 
					pd.put("msg", "ok");
					
				}
				else {
					//第三个参数
					String two003 = groupMemService.searchdeletethird(pd);
					pd.put("SIX", two003);
					System.out.println(pd.get("SIX")+"===============4444为null============");
					
					pd.put("cmd", pd.get("FOUR")+","+"1"+","+pd.get("FOUR")+","+pd.get("FIVE")+","+pd.get("SIX"));
					System.out.println(pd.get("cmd")+"===============5555为null============");
					////插入最后一张命令表
					groupMemService.finallydeletepage(pd); 
					pd.put("msg", "ok");
				}
				 
			}	
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	
}
