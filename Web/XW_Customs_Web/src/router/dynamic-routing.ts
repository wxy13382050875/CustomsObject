import Layout from "@/components/layout/Main.vue";
import { RouteRecordRaw } from "vue-router";
const DYNAMIC_ROUTING: Array<RouteRecordRaw> = [
    {
        path: "/",
        component: Layout,
        redirect: "/user",
        children: [
            {
                path: "/user",
                component: () => import("@/views/user/List.vue"),
                meta: {
                    title: "用户列表",
                    keepAlive: true
                }
            },
            {
                path: "/user/add",
                component: () => import("@/views/user/Add.vue"),
                meta: {
                    title: "新增用户"
                }
            },
            {
                path: "/permission",
                component: () => import("@/views/permission/List.vue"),
                meta: {
                    title: "权限管理",
                    keepAlive: true
                }
            },
            {
                path: "/org",
                component: () => import("@/views/org/List.vue"),
                meta: {
                    title: "机构管理",
                    keepAlive: true
                }
            },
            {
                path: "/role",
                component: () => import("@/views/role/AllList.vue"),
                meta: {
                    title: "角色管理",
                    keepAlive: true
                }
            },
            // {
            //     path: "/app",
            //     component: () => import("@/views/app/List.vue"),
            //     meta: {
            //         title: "应用管理",
            //         keepAlive: true
            //     }
            // }
        ]
    }
];

const Qk_DYNAMIC_ROUTING: Array<RouteRecordRaw> = [
    {
        path: "/user",
        component: () => import("@/views/user/List.vue"),
        meta: {
            title: "用户列表",
            keepAlive: true
        }
    },
    {
        path: "/user/add",
        component: () => import("@/views/user/Add.vue"),
        meta: {
            title: "新增用户"
        }
    },
    {
        path: "/permission",
        component: () => import("@/views/permission/List.vue"),
        meta: {
            title: "权限管理",
            keepAlive: true
        }
    },
    {
        path: "/org",
        component: () => import("@/views/org/List.vue"),
        meta: {
            title: "机构管理",
            keepAlive: true
        }
    },
    {
        path: "/role",
        component: () => import("@/views/role/List.vue"),
        meta: {
            title: "角色管理",
            keepAlive: true
        }
    },
    {
        path: "/app",
        component: () => import("@/views/role/AllList.vue"),
        meta: {
            title: "应用管理",
            keepAlive: true
        }
    }
];
export { DYNAMIC_ROUTING, Qk_DYNAMIC_ROUTING };
