package com.test.check;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;




public class ConsoleRead {
	static String s = null;
	static String sub = null;
	static List<String> devicename = new ArrayList<String>();
	
	/**
	 * @param args
	 */
	public static void main(String a[])
	{
		ConsoleRead consoleRead=new ConsoleRead();
		List<String> list=consoleRead.getDevice();
		System.out.println(list);
	}
	public  List<String> getDevice()
	{

		try {

			Process p = Runtime.getRuntime().exec("adb devices");

			BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));

			// read the output from the command
			while ((s = stdInput.readLine()) != null) {

				sub = StringUtils.substringBetween(s, "emulator-", "\tdevice");
				if (sub != null)
					devicename.add(sub);
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return devicename;
		
	}
	

}