package com.technology.center.handler;

import org.json.JSONException;
import org.json.JSONObject;

public interface MsgHandlerCallBack {

    void handlerMessage(JSONObject data) throws JSONException;

    void handlerMessage(String data) throws Exception;
}
