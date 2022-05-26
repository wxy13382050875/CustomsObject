// store.ts
import { InjectionKey } from "vue";
import { createStore, useStore as baseUseStore, Store } from "vuex";
// 引入tab模块
import tabs, { TabsState } from "./modules/tabs";
// 引入menu模块
import menu, { MenuState } from "./modules/menu";
// 引入user 模块
import user, { UserState } from "./modules/user";
//引入sys
import sys, { SysState } from "./modules/sys";
// 引入vuex-ts自定义类型推断类，代码提示的核心
import { CommonStore } from "./vuex_ts";
// 定义根级State类型
export type RootState = {
    tabs: TabsState;
    menu: MenuState;
    user: UserState;
    sys: SysState;
};

// 把多个模块聚合在一起
export const modules = {
    tabs: tabs,
    menu: menu,
    user: user,
    sys: sys
};

export const key: InjectionKey<Store<RootState>> = Symbol();

export const store = createStore<RootState>({
    modules
}) as CommonStore;

// 定义自己的 `useStore` 组合式函数
export function useStore(): CommonStore {
    return baseUseStore(key);
}
