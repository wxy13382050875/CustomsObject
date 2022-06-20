import axios, { AxiosRequestConfig, AxiosResponse, AxiosError } from "axios";
import { store } from "@/store";
import { message } from "ant-design-vue";
import router from "@/router";
/* 创建axios实例 */
const http = axios.create({
    baseURL: "http://api.bt-dev.yndth.cn",
    timeout: 5000 * 10 // 请求超时时间
});

//请求拦截
http.interceptors.request.use((config: AxiosRequestConfig) => {
    const token = store.getters["user/getToken"];
    if (token && config.url !== "/login") {
        config.headers!["Authorization"] = token;
    }
    return config;
});

//响应拦截
http.interceptors.response.use(
    (response: AxiosResponse) => {
        const { data } = response;
        if (data.code === "200") {
            return data.data;
        } else {
            if (data.code === "403") {
                sessionStorage.clear();
                router.push("/login");
                message.info("登陆失效请重新登陆");
            } else {
                message.info(data.message);
                return Promise.reject(data);
            }
        }
    },
    (error: AxiosError) => {
        if (!error.response) {
            message.error("连接失败，请检查网络！");
        } else {
            message.error("请求出错：" + error.response.status);
        }
        return Promise.reject("");
    }
);

export default http;
