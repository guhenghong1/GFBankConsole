package com.bank.console.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

public class JSONUtil {
	public static String getData()  {
		InputStream in = Object.class.getResourceAsStream("/file");
		BufferedReader buffer = new BufferedReader(new InputStreamReader(in));
		StringBuffer sb = new StringBuffer();
		String str = "";
		try {
			while((str = buffer.readLine()) != null) {
				sb.append(str);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sb.toString();
	}
	

  
    public static void JsonObject2HashMap(JSONObject jo, List<Map<?, ?>> rstList) {  
        for (Iterator<String> keys = jo.keys(); keys.hasNext();) {  
            try {  
                String key1 = keys.next();  
                System.out.println("key1---" + key1 + "------" + jo.get(key1)  
                        + (jo.get(key1) instanceof JSONObject) + jo.get(key1)  
                        + (jo.get(key1) instanceof JSONArray));  
                if (jo.get(key1) instanceof JSONObject) {  
  
                    JsonObject2HashMap((JSONObject) jo.get(key1), rstList);  
                    continue;  
                }  
                if (jo.get(key1) instanceof JSONArray) {  
                    JsonArray2HashMap((JSONArray) jo.get(key1), rstList);  
                    continue;  
                }  
                System.out.println("key1:" + key1 + "----------jo.get(key1):"  
                        + jo.get(key1));  
                json2HashMap(key1, jo.get(key1), rstList);  
  
            } catch (JSONException e) {  
                e.printStackTrace();  
            }  
  
        }  
  
    }  
    public static void JsonArray2HashMap(JSONArray joArr,  
            List<Map<?, ?>> rstList) {  
        for (int i = 0; i < joArr.size(); i++) {  
            try {  
                if (joArr.get(i) instanceof JSONObject) {  
  
                    JsonObject2HashMap((JSONObject) joArr.get(i), rstList);  
                    continue;  
                }  
                if (joArr.get(i) instanceof JSONArray) {  
  
                    JsonArray2HashMap((JSONArray) joArr.get(i), rstList);  
                    continue;  
                }  
                System.out.println("Excepton~~~~~");  
  
            } catch (JSONException e) {  
                e.printStackTrace();  
            }  
  
        }  
  
    }  
  
    public static void json2HashMap(String key, Object value,  
            List<Map<?, ?>> rstList) {  
        HashMap<String, Object> map = new HashMap<String, Object>();  
        map.put(key, value);  
        rstList.add(map);  
    }  
	
	public static void main(String[] args) {
		ArrayList<Map<?, ?>> rstList = new ArrayList<Map<?, ?>>();  
		String jsonStr = JSONUtil.getData();
		JSONUtil.JsonObject2HashMap(JSONObject.fromObject(jsonStr), rstList);  
		System.out.println("---------rstList" + rstList);  
//		System.out.println("str=== "+jsonStr);
	}
}
