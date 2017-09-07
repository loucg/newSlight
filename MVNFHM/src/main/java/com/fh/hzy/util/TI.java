package com.fh.hzy.util;


public class TI implements Comparable<TI>{
	String timestamp;
	int intensity;
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public int getIntensity() {
		return intensity;
	}
	public void setIntensity(int intensity) {
		this.intensity = intensity;
	}
	@Override
	public int compareTo(TI o) {
		// TODO Auto-generated method stub
		String[] times = o.getTimestamp().split(":");
		String[] this_times = timestamp.split(":");
 		if(Integer.valueOf(times[0])>Integer.valueOf(this_times[0])){
 			return -1;
 		}else if(Integer.valueOf(times[0])<Integer.valueOf(this_times[0])){
 			return 1;
 		}else{
 			if(Integer.valueOf(times[1])>Integer.valueOf(this_times[1])){
 				return -1; 
 			}else if(Integer.valueOf(times[1])<Integer.valueOf(this_times[1])){
 				return 1;
 			}else{
 				return 0;
 			}
 		}
	}
	
	
}
