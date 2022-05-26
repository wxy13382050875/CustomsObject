import http from "@/utils/http";

/**
 * 添加角色
 * @param params
 * @returns
 */
export const addRole = (params: any) => {
    return http.post("role", params);
};

/**
 * 更新角色
 * @param params
 * @returns
 */
export const updateRole = (params: any) => {
    return http.put(`/role/${params.id}`, params);
};

/**
 * 获取角色下的权限
 * @param roleId
 * @param params
 * @returns
 */
export const getRolePermission = (roleId: number, params: any) => {
    return http.get(`/role/${roleId}/permissions`, { params: params });
};

/**
 * 保存给角色分配的权限信息
 * @param roleId
 * @param params
 * @returns
 */
export const saveRoleForPermission = (roleId: number, params: number[]) => {
    return http.post(`/role/${roleId}/permissions`, params);
};
