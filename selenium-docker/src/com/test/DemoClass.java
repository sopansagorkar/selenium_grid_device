package com.test;

import io.appium.java_client.android.AndroidDriver;
import java.net.MalformedURLException;
import java.net.URL;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.remote.DesiredCapabilities;

public class DemoClass {

	public static void main(String[] args) 
	{
		WebDriver driver;

		DesiredCapabilities capabilities = new DesiredCapabilities();
		capabilities.setCapability("automationName", "Appium");
		capabilities.setCapability("deviceName", "5554");
		capabilities.setCapability("platformName", "Android");
		capabilities.setCapability("platformVersion", "4.4.2");
		capabilities.setCapability("appActivity",
				"io.selendroid.testapp.HomeScreenActivity");
		capabilities.setCapability("fullReset", true);
		capabilities
				.setCapability("app",
						"/home/sopan/workspace/Selenium_Docker/lib/selendroid-test-app-0.17.0.apk");
		try {
			driver = new AndroidDriver(new URL("http://127.0.0.1:4723/wd/hub"),
					capabilities);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}

	}

}
