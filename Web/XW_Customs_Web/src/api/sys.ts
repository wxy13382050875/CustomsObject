import http from "@/utils/http";

/**
 * 登陆
 * @param params
 * @returns
 */
export const login = (params: { username: string; password: string }): Promise<string> => {
    return http.post("/login", params);
};

/**
 * 获取权限
 */
export const getPermission = () => {
    return http.get("/permission");
};
