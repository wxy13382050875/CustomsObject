import { IUser } from "@/interface/IUser";
import http from "@/utils/http";

/**
 * 用户列表 根据应用id和orgId进行查询
 * @param params
 * @returns
 */
export const userList = (params: { appId: string; orgId: string }) => {
    return http.get("/sso/user", { params: params });
};

/**
 * 保存用户信息
 * @param user
 * @returns
 */
export const saveUserInfo = (user: IUser) => {
    return http.post("/sso/user/register", user);
};

/**
 * 修改信息
 * @param user
 * @returns
 */
 export const putUserInfo = (userId: number,user: IUser) => {
    return http.put(`/sso/user/${userId}/`, user);
};

/**
 * 根据用户id获取 当前用户 所挂载的机构树形
 * @param id
 */
export const getUserOrgById = (userId: number): Promise<any> => {
    return http.get(`/sso/user/${userId}/canSelectOrgs`);
};

/**
 * 给用户分配机构
 * @param ids 机构列表
 * @param userId 用户id
 */
export const userAssigningOrg = (userId: number | undefined, ids: number[]) => {
    return http.post(`/sso/user/${userId}/orgs`, ids);
};

/**
 * 根据id查询用户详情
 * @param userId
 * @returns
 */
export const userInfoDetail = (userId: number) => {
    return http.get(`/sso/user/${userId}`);
};

/**
 * 用户可分配的角色列表
 * @param userId
 * @returns
 */
export const userRoleList = (userId: number) => {
    return http.get(`/sso/user/${userId}/canSelectRoles`);
};

/**
 * 提交用户分配角色数据
 * @param userId
 * @param rolesIds
 * @returns
 */
export const userAssigningRole = (userId: number, rolesIds: number[]) => {
    return http.post(`/sso/user/${userId}/roles`, rolesIds);
};
/**
 * 批量删除用户，删除用户-角色关系、删除用户-组织关系
 * @param roleId
 * @param params
 * @returns
 */
 export const deleteUser = ( id: number) => {
    return http.delete(`/sso/user`,  { data: [id] });
};
/**
 * 委托单位分页列表
 * @param userId
 * @returns
 */
 export const entrustOrgList = (params: any) => {
    return http.get(`/bt_cus_tc/entrustOrg`,{ params: params });
};