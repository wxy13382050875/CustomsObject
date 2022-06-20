import http from "@/utils/http";

/**
 * 登陆
 * @param params
 * @returns
 */
export const login = (params: { username: string; password: string }): Promise<string> => {
    return http.post("/sso/login", params);
};

/**
 * 获取权限
 */
export const getPermission = () => {
    return http.get("/sso/permission");
};
/**
 * 当前登陆用户信息
 */
 export const getCurrentUser = () => {
    return http.get("/sso/user/current");
};