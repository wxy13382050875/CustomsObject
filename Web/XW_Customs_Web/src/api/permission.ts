import http from "@/utils/http";
// import { IPermission } from "@/interface/IPermission";
//应用下的权限列表
export const permissionList = (params: { appId: number; type: string }) => {
    return http.get("/sso/permission/tree", { params: params });
};

//添加权限
export const savePermission = (params: any) => {
    return http.post("/sso/permission", params);
};

//修改权限
export const updatePermission = (params: any) => {
    return http.put(`/sso/permission/${params.id}`, params);
};

//权限详情
export const permissionInfo = (id: number) => {
    return http.get(`/sso/permission/${id}`);
};

//删除
export const deletePermission = (id: number) => {
    return http.delete(`/sso/permission`, { data: [id] });
};

