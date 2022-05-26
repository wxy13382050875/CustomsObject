import http from "@/utils/http";

//根据应用查询机构
export const orgList = (appId: string) => {
    return http.get(`/org/tree`, { params: { appId: appId } });
};

//更新机构
export const orgUpdate = (params: any) => {
    return http.put(`/org/${params.id}`, params);
};

//添加机构
export const orgSave = (params: any) => {
    return http.post("/org", params);
};

//机构下的权限
export const orgPermissionList = (orgId: number, params: any) => {
    return http.get(`/org/${orgId}/permissions`, { params: params });
};

//给机构添加权限
export const orgAssignPermissions = (orgId: number, ids: number[]) => {
    return http.post(`/org/${orgId}/permissions`, ids);
};

//机构下的角色
export const roleOfOrgList = (orgId: number) => {
    return http.get(`/org/${orgId}/roles`);
};
