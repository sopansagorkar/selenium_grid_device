package com.test;

import java.net.MalformedURLException;
import java.net.URL;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;

import com.test.check.ConsoleRead;

public class WebAndroid {
	WebDriver driver;

	@Test
	public void runTest() throws MalformedURLException, InterruptedException {
		DesiredCapabilities capibilities = new DesiredCapabilities();
		ConsoleRead consoleRead=new ConsoleRead();
		capibilities.setCapability("automationName", "Appium");
		capibilities.setBrowserName("note"); // use chrome for Chrome browser
		capibilities.setCapability("deviceName", "5554"); // update device name
		//capibilities.setCapability("platformVersion", "4.4.2"); // update
																// platform
																// version
		capibilities.setCapability("platformName", "ANDROID");
		capibilities.setCapability("browserName", "Browser");

		driver = new RemoteWebDriver(new URL("http://172.17.0.2:4444/wd/hub"),
				capibilities);
		driver.get("http://www.google.com/");
		driver.findElement(By.id("lst-ib")).sendKeys("Java");
		driver.findElement(By.name("btnG")).click();

	}
}
