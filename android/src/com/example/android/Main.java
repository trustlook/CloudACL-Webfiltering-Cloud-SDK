package com.example.android;

import java.io.PrintWriter;
import java.io.StringWriter;

import com.example.android.R;
import com.cloudacl.webservice.WebfilteringService;

import android.os.Bundle;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class Main extends Activity implements View.OnClickListener {
    EditText keyText;
    EditText urlText;
    EditText resultIdText;
    EditText resultUrlText;
    EditText resultDescText;
    Button retrieveButton;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        keyText = (EditText)findViewById(R.id.key);
        urlText = (EditText)findViewById(R.id.url);
        resultIdText = (EditText)findViewById(R.id.result_id);
        resultUrlText = (EditText)findViewById(R.id.result_url);
        resultDescText = (EditText)findViewById(R.id.result_desc);
        retrieveButton = (Button)findViewById(R.id.retrieve_button);
        retrieveButton.setOnClickListener(this);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public void onClick(View v) {
        String key = keyText.getText().toString();
        String url = urlText.getText().toString();
        try {
            WebfilteringService.UrlCategory result;
            result = WebfilteringService.getInstance().getCategoryByUrl(key, url);
            resultIdText.setText(result.getId());
            resultUrlText.setText(result.getUrl());
            resultDescText.setText(result.getDesc());
        } catch (Exception e) {
            StringWriter errors = new StringWriter();
            e.printStackTrace(new PrintWriter(errors));
            AlertDialog.Builder ad = new AlertDialog.Builder(this);
            ad.setTitle(getString(R.string.error));
            ad.setMessage(errors.toString());
            ad.setPositiveButton(getString(R.string.ok), new OnClickListener() {
                public void onClick(DialogInterface dialog, int arg1) {
                    return;
                }
            });
            ad.create().show();
        }
    }
}
