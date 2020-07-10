package com.example.flutter_boost_android;

import android.app.Application;
import android.content.Context;


/**
 * Created by xht on 2020/6/23
 */
public class MyApplication extends Application {
    private static Context context;
    @Override
    public void onCreate() {
        super.onCreate();
        context = getApplicationContext();
        BoostHelper.initBoost(this);
    }

    public static Context getContext() {
        return context;
    }
}
