package com.cloudacl.webservice.android;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONException;
import org.json.JSONObject;

import android.os.StrictMode;

public class WebfilteringService {
    static private final String webfilteringBaseUrl =
            "https://api.cloudacl.com/webfiltering-webapp/webapi/webcategories/";
    static WebfilteringService INSTANCE = null;
    static public WebfilteringService getInstance() {
        if (INSTANCE == null) {
            return new WebfilteringService();
        }
        return INSTANCE;
    }
    
    public static class UrlCategory {
        private String id;
        private String url;
        private String desc;
        public UrlCategory(String id, String url, String desc) {
            this.id = id;
            this.url = url;
            this.desc = desc;
        }
        public String getId() {
            return id;
        }
        public String getUrl() {
            return url;
        }
        public String getDesc() {
            return desc;
        }
    }
    
    public UrlCategory getCategoryByUrl(String key, String url) throws IOException, JSONException {
        if (android.os.Build.VERSION.SDK_INT > 9) {
            StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder()
                    .permitAll().build();
            StrictMode.setThreadPolicy(policy);
        }
        
        HttpClient httpClient = new DefaultHttpClient();
        String requestUrl = String.format("%s%s?url=%s&key=%s", 
            webfilteringBaseUrl, "getCategoryByUrl", url, key);
        HttpGet httpGet = new HttpGet(requestUrl);
        HttpResponse response = httpClient.execute(httpGet);
        
        HttpEntity entity = response.getEntity();
        if (entity == null) {
            throw new IOException("Fail to get result from request");
        }
        InputStream instream = entity.getContent();
        BufferedReader reader = new BufferedReader(new InputStreamReader(instream));
        StringBuilder sb = new StringBuilder();
        String line = null;
        while ((line = reader.readLine()) != null)
        {
            sb.append(line + "\n");
        }
        JSONObject json = new JSONObject(sb.toString());
        String r_id = json.getString("id");
        String r_url = null;
        try {
            r_url = json.getString("url");
        } catch (JSONException e) {
        }
        String r_desc = json.getString("desc");
        reader.close();
        
        return new UrlCategory(r_id, r_url, r_desc);
    }
}
