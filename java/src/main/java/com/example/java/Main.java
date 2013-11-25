package com.example.java;

import java.io.IOException;

import org.json.simple.parser.ParseException;

import com.cloudacl.webfiltering.java.WebfilteringService;

public class Main {
    public static void main(String[] args) throws IOException, ParseException {
        if (args.length!=2) {
            System.out.println("Usage: program key url");
            System.exit(1);
        }
        String key = args[0];
        String url = args[1];
        WebfilteringService.UrlCategory cateory = WebfilteringService.getInstance().getCategoryByUrl(key, url);
        System.out.println("errorcode:" + cateory.getErrorCode());
        System.out.println("id:" + cateory.getId());
        if (cateory.getUrl()!=null) {
            System.out.println("url:" + cateory.getUrl());
        }
        System.out.println("desc:" + cateory.getDesc());
    }
}
