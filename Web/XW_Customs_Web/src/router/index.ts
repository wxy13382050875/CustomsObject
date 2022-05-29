import { createRouter, createWebHistory, RouteRecordRaw } from "vue-router";
import { store } from "@/store";
import { Qk_DYNAMIC_ROUTING } from "./dynamic-routing";
import { message } from "ant-design-vue";
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

const blacklist = ["/","/login"]
router.beforeEach((to) => {
    //如果路由列表为0 则重新匹配路由
    
    // store.dispatch("tabs/addAsyncTabs", {
    //     title: to.meta.title as string,
    //     path: to.path,
    //     params: to.params,
    //     query: to.query
    // });
    if (!store.getters["user/getToken"] && to.path !== "/login") {
        message.info("登录失效，请重新登录");
        sessionStorage.clear();
        return { path: "/login", replace: true };
    } else {
        if (store.getters["user/getRouteList"].length === 0) {
            store.dispatch("user/getAuthorityRouting");
            console.log("fuck");
            return { path: to.path };
        }
        if (!blacklist.includes(to.path)) {
            
            store.dispatch("tabs/addAsyncTabs", {
                title: to.meta.title as string,
                path: to.path,
                params: to.params,
                query: to.query
            });
        }
    }
});

export default router;
