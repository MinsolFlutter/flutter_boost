package com.example.flutter_boost_android;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;

import com.idlefish.flutterboost.containers.BoostFlutterActivity;


import java.util.HashMap;
import java.util.Map;

/**
 * 路由管理
 */
public class PageRouter {
    public final static String FirstPageUrl = "url://firstPage";
    public final static String NativePage = "url://nativePage";

    public final static Map<String, String> pageName = new HashMap<String, String>() {{
        put(FirstPageUrl, "/first");
    }};

    public static boolean openPageByUrl(Context context, String url, Map params) {
        return openPageByUrl(context, url, params, 0);
    }

    public static boolean openPageByUrl(Context context, String url, Map params, int requestCode) {

        String path = url.split("\\?")[0];  // 过滤query参数

        Log.i("Flutter OpenUrl：", "---Path-->" + path + "---Url--->" + url);

        String flutterPage = null;
        if (url.startsWith(FirstPageUrl)) {
            // 跳转flutter界面
            flutterPage = pageName.get(FirstPageUrl);
            openFlutterPage(context, params, requestCode, flutterPage);
            return true;
        } else if (url.startsWith(NativePage)) {
            // 跳转原生界面
            String aNative = (String) params.get("native");
            Bundle bundle = new Bundle();
            bundle.putString("native", aNative);
            context.startActivity(new Intent(context, NativePageActivity.class).putExtras(bundle));
            return true;
        }
        return false;
    }

    /**
     * 打开flutter页面
     *
     * @param context
     * @param params
     * @param requestCode
     * @param url
     */
    private static void openFlutterPage(Context context, Map params, int requestCode, String url) {
        // 跳转flutter界面
        Intent intent = BoostFlutterActivity.withNewEngine().url(url).params(params)
                .backgroundMode(BoostFlutterActivity.BackgroundMode.opaque).build(context);
        if (context instanceof Activity) {
            Activity activity = (Activity) context;
            activity.startActivityForResult(intent, requestCode);
        }
    }

    /**
     * 打开原生页面
     *
     * @param context
     * @param url
     * @param params
     * @param requestCode
     * @return
     */
    private static boolean openNativePage(Context context, String url, Map params, int requestCode) {
        String paramsStr = (String) params.get("native");
        Bundle bundle = new Bundle();
        bundle.putString("native", paramsStr);
        Intent intent = new Intent().setData(Uri.parse(url)).putExtras(bundle);
        if (context instanceof Activity) {
            Activity activity = (Activity) context;
            activity.startActivityForResult(intent, requestCode);
        } else {
            context.startActivity(intent);
        }
        return true;
    }

}
