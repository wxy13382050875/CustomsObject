import { createRouter, createWebHistory, RouteRecordRaw } from "vue-router";
import { store } from "@/store";
import { Qk_DYNAMIC_ROUTING } from "./dynamic-routing";
// eslint-disable-next-line @typescript-eslint/no-var-requires
const APP_NAME = require("../../package.json").name;

const STATIC_ROUTE: Array<RouteRecordRaw> = [
    {
        path: "/:pathMatch(.*)*",
        component: () => import("@/views/PageNotFound.vue")
    },
    {
        path: "/login",
        component: () => import("@/views/Login.vue")
    }
];

if ((window as any).__POWERED_BY_QIANKUN__) {
    STATIC_ROUTE.push(...Qk_DYNAMIC_ROUTING);
}

const router = createRouter({
    history: createWebHistory((window as any).__POWERED_BY_QIANKUN__ ? "/auth" : "/"),
    routes: STATIC_ROUTE
});

router.beforeEach((to) => {
    //如果路由列表为0 则重新匹配路由
    if (store.getters["user/getRouteList"].length === 0) {
        store.dispatch("user/getAuthorityRouting");
        console.log("fuck");
        return { path: to.path };
    }
    store.dispatch("tabs/addAsyncTabs", {
        title: to.meta.title as string,
        path: to.path,
        params: to.params,
        query: to.query
    });
});

export default router;
