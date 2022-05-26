import { DYNAMIC_ROUTING } from "@/router/dynamic-routing";
import { ActionContext } from "vuex";
import { RootState } from "@/store";
import { MenuList } from "@/data/permission";
import router from "@/router";
import { getAuthRouters, createAuthRouters } from "@/utils/permission";

//权限类型
interface IPermission {
    key: number;
    name: string;
    url?: string;
    icon?: string;
    status: string;
    children?: [];
}

export type UserState = {
    token: string; //token
    permissionList: IPermission[]; //权限列表
    routeList: any[]; //路由列表
};

// 定义user模块下的state
export const state: UserState = {
    token: sessionStorage.getItem("token") || "",
    permissionList: sessionStorage.getItem("PermissionList")
        ? (JSON.parse(sessionStorage.getItem("PermissionList") || "[]") as IPermission[])
        : [],
    routeList: []
};

export const getters = {
    getToken(state: UserState): string {
        return state.token;
    },
    getPermission(state: UserState): IPermission[] {
        return state.permissionList;
    },
    getRouteList(state: UserState) {
        return state.routeList;
    }
};

export const mutations = {
    ["SET_TOKEN"](state: UserState, token: string): void {
        state.token = token;
        sessionStorage.setItem("token", token);
    },
    ["AUTHORITY_ROUTING"](state: UserState) {
        const menuList = getAuthRouters(MenuList);
        const routeList = createAuthRouters(menuList)(DYNAMIC_ROUTING, "/");
        state.routeList = routeList;
    }
};

export const actions = {
    setToken({ commit }: ActionContext<UserState, RootState>, token: string) {
        commit("SET_TOKEN", token);
    },
    getAuthorityRouting({ commit }: ActionContext<UserState, RootState>) {
        return new Promise((resolve, reject) => {
            try {
                commit("AUTHORITY_ROUTING");
                state.routeList.forEach((item) => {
                    router.addRoute(item);
                });
                resolve(state.routeList);
            } catch (error) {
                reject(error);
            }
        });
    }
};

export default {
    namespaced: true, // 声明命名空间
    state,
    mutations,
    actions,
    getters
};
