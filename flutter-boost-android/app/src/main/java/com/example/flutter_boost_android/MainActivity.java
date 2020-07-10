package com.example.flutter_boost_android;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;


public class MainActivity extends AppCompatActivity implements View.OnClickListener  {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        //给第一个按钮设置点击事件
        findViewById(R.id.btn_click_one).setOnClickListener(this);
    }
    @Override
    public void onClick(View v) {
        HashMap params = new HashMap<String, String>();
        params.put("Firstkey", "我是参数->A");
        PageRouter.openPageByUrl(MainActivity.this, PageRouter.FirstPageUrl, params);
    }
}