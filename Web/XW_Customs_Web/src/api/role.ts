import http from "@/utils/http";

/**
 * 添加角色
 * @param params
 * @returns
 */
export const addRole = (params: any) => {
    return http.post("/sso/role", params);
};

/**
 * 更新角色
 * @param params
 * @returns
 */
export const updateRole = (params: any) => {
    return http.put(`/sso/role/${params.id}`, params);
};
/**
 * 获取角色分页查询
 * @param roleId
 * @param params
 * @returns
 */
 export const getRoleList = ( params: any) => {
    return http.get("/sso/role", { params: params });
};
/**
 * 获取角色下的权限
 * @param roleId
 * @param params
 * @returns
 */
export const getRolePermission = (roleId: number, params: any) => {
    return http.get(`/sso/role/${roleId}/permissions`, { params: params });
};

/**
 * 保存给角色分配的权限信息
 * @param roleId
 * @param params
 * @returns
 */
export const saveRoleForPermission = (roleId: number, params: number[]) => {
    return http.post(`/sso/role/${roleId}/permissions`, params);
};

/**
 * 删除
 * @param roleId
 * @param params
 * @returns
 */
 export const deleteRole = ( id: number) => {
    return http.delete(`/sso/role`,  { data: [id] });
};