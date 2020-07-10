package com.example.flutter_boost_android;

import android.os.Bundle;
import android.view.View;
import android.widget.TextView;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import java.util.HashMap;
import java.util.Map;

public class NativePageActivity extends AppCompatActivity implements View.OnClickListener {

    private TextView mOpenNative;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.native_page);
        mOpenNative = findViewById(R.id.info);
        mOpenNative.setText(getIntent().getExtras().getString("native"));

        findViewById(R.id.btn_click).setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        HashMap params = new HashMap<String, String>();
        params.put("Firstkey", "我是参数->A");
        PageRouter.openPageByUrl(NativePageActivity.this, PageRouter.FirstPageUrl, params);
    }
}