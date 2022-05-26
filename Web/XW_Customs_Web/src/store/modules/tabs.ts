import { LocationQueryRaw, RouteParamsRaw } from "vue-router";
// tabs.ts

import { ActionContext } from "vuex";
import { RootState } from "@/store";
// 定义单个tab的类型
interface ITab {
    title: string;
    path: string;
    query: LocationQueryRaw | undefined;
    params: RouteParamsRaw | undefined;
}
// 定义tabs模块下的，state的类型
export type TabsState = {
    tabList: ITab[];
    refresh: boolean;
};

// 定义tabs模块下的state
export const state: TabsState = {
    tabList: sessionStorage.getItem("TAB_LIST")
        ? JSON.parse(sessionStorage.getItem("TAB_LIST") || "{}")
        : [],
    refresh: false
};
// 定义tabs模块下的getters
export const getters = {
    getTabs(state: TabsState) {
        return state.tabList.length > 0 ? state.tabList : sessionStorage.getItem("TAB_LIST");
    }
};
// 定义tabs模块下的mutations
export const mutations = {
    addTab(state: TabsState, tab: ITab): void {
        if (state.tabList.some((item) => item.path === tab.path)) {
            return;
        }
        state.tabList.push(tab);
        sessionStorage.setItem("TAB_LIST", JSON.stringify(state.tabList));
    },
    deleteTabs(state: TabsState, tab: ITab): void {
        const index = state.tabList.findIndex((item) => item.path === tab.path);
        state.tabList.splice(index, 1);
        sessionStorage.setItem("TAB_LIST", JSON.stringify(state.tabList));
    }
};
// 定义tabs模块下的actions
export const actions = {
    addAsyncTabs({ commit }: ActionContext<TabsState, RootState>, tab: ITab) {
        commit("addTab", tab);
    },
    deleteTabs({ commit }: ActionContext<TabsState, RootState>, tab: ITab) {
        commit("deleteTabs", tab);
    }
};

export default {
    namespaced: true, // 声明命名空间
    state,
    mutations,
    actions,
    getters
};
