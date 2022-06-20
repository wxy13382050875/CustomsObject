import axios from "axios";
import http from "@/utils/http";

const URL = "http://bt-static.yndth.cn/upload";

//上传图片
export const uploadFile = (file: any) => {
	const params = new FormData();
	params.append("fileType", "1004");
	params.append("project", "enterprise-website");
	params.append("password", "heihei");
	params.append("file", file);

	return axios({
		method: "post",
		baseURL: URL,
		data: params,
		headers: {
			"Content-Type": "multipart/form-data"
		}
	});
};

// 登陆
export const login = (params: any) => {
	return http.post("/sso/user/login", params);
};

//登出
export const loginOut = () => {
	return http.post("/sso/user/logout");
};
