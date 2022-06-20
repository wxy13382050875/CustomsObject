import Layout from "@/components/layout/Main.vue";
import { RouteRecordRaw } from "vue-router";
const DYNAMIC_ROUTING: Array<RouteRecordRaw> = [
    {
        path: "/",
        component: Layout,
        redirect: "/orgList",
        children: [
            {
                path: "/orgList",
                component: () => import("@/views/user/OrgList.vue"),
                meta: {
                    title: "用户列表",
                    keepAlive: true
                }
            },
            {
                path: "/unitList",
                component: () => import("@/views/user/UnitList.vue"),
                meta: {
                    title: "委托单位",
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
                path: "/sysRoleList",
                component: () => import("@/views/role/sysRoleList.vue"),
                meta: {
                    title: "系统角色",
                    keepAlive: true
                }
            },
            {
                path: "/orgRoleList",
                component: () => import("@/views/role/orgRoleList.vue"),
                meta: {
                    title: "机构角色",
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
        path: "/orgList",
        component: () => import("@/views/user/OrgList.vue"),
        meta: {
            title: "用户列表",
            keepAlive: true
        }
    },
    {
        path: "/unitList",
        component: () => import("@/views/user/UnitList.vue"),
        meta: {
            title: "委托单位",
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
        path: "/sysRoleList",
        component: () => import("@/views/role/sysRoleList.vue"),
        meta: {
            title: "系统角色",
            keepAlive: true
        }
    },
    {
        path: "/orgRoleList",
        component: () => import("@/views/role/orgRoleList.vue"),
        meta: {
            title: "机构角色",
            keepAlive: true
        }
    },
    {
        path: "/app",
        component: () => import("@/views/role/sysRoleList.vue"),
        meta: {
            title: "应用管理",
            keepAlive: true
        }
    }
];
export { DYNAMIC_ROUTING, Qk_DYNAMIC_ROUTING };
