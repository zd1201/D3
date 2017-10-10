package com.ymtech.kr.controller;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ymtech.kr.controller.model.ResponseData;

@RestController
public class BarController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value ="/getBarData", produces="application/json", method = RequestMethod.GET) 
	@ResponseBody
	public ResponseEntity<Object> getData(
	HttpServletRequest request, HttpServletResponse response) {
		
		if(logger.isInfoEnabled()){
			logger.info("start getData");
		}
		
		ResponseData responseData = new ResponseData();
		
		 // 1 ~ 30까지 랜덤 숫자 구하기
        int random = (int) (Math.random() * 30) + 1;
//        double random = Math.random() * 30 + 10;
		
        responseData.setCode(ResponseData.SUCCESS_CODE);
	    responseData.setValue(random);
	    
		return new ResponseEntity<Object>(responseData, HttpStatus.OK);
			
	}
	
	@RequestMapping(value ="/getLineData", produces="application/json", method = RequestMethod.GET) 
	@ResponseBody
	public ResponseEntity<Object> getLineData(
	HttpServletRequest request, HttpServletResponse response) {
		
		if(logger.isInfoEnabled()){
			logger.info("start getLineData");
		}
		
		ResponseData responseData = new ResponseData();
		
		 // 1 ~ 30까지 랜덤 숫자 구하기
        int random = (int) (Math.random() * 30) + 1;
        
//        double random = Math.random() * 30 + 10;
		
        responseData.setCode(ResponseData.SUCCESS_CODE);
	    responseData.setValue(random);
	    
		return new ResponseEntity<Object>(responseData, HttpStatus.OK);
			
	}
	
	@RequestMapping(value ="/getStackData", produces="application/json", method = RequestMethod.GET) 
	@ResponseBody
	public ResponseEntity<Object> getStackData(
	HttpServletRequest request, HttpServletResponse response) {
		
		if(logger.isInfoEnabled()){
			logger.info("start getLineData");
		}
		
		ResponseData responseData = new ResponseData();
		
		 // 1 ~ 30까지 랜덤 숫자 구하기
        int random1 = (int) (Math.random() * 30) + 1;
        int random2 = (int) (Math.random() * 30) + 1;
        int random3 = (int) (Math.random() * 30) + 1;
        
        Integer result[] = {random1, random2, random3};
        		
//       double random = Math.random() * 30 + 10;
		
        responseData.setCode(ResponseData.SUCCESS_CODE);
	    responseData.setValue(result);
	    
		return new ResponseEntity<Object>(responseData, HttpStatus.OK);
			
	}
	
	
	
    private void run(String path, String encoding) {
        BufferedReader br = null;
        String line;
        String cvsSplitBy = "\t";

        try {
            br = new BufferedReader(new InputStreamReader(new FileInputStream(path), encoding));
            while ((line = br.readLine()) != null) {
                String[] field = line.split(cvsSplitBy);
                System.out.println(field[0]);
                break;
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

}
