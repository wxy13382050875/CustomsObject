<script setup lang="ts">
import SiderMenu from "./SiderMenu.vue";
import NavTags from "./NavTags.vue";
import { useStore } from "@/store";

const store = useStore();
/**
        * 退出登录操作 清除用户信息缓存 权限
        */
const loginOut = () => {
    store.dispatch("user/setToken", "");
    store.dispatch("user/setAppId", "");
    location.href = '/login';
}
</script>
<template>
    <a-layout>
        <a-layout-header>
            <div style="justify-content:space-between;display: flex;width: 100%;">
            <div style="display: flex; align-items: center;">
                <img :width="40" height="40" src="@/assets/icon_logo.png" />
                <div style=" color: #ffffff; font-size: 22px; margin-left: 10px;"> 海关技术中心</div>
            </div>
                
                <a-dropdown>
                    <a class="ant-dropdown-link" @click.prevent>
                        个人中心
                        <DownOutlined />
                    </a>
                    <template #overlay>
                        <a-menu>
                            <a-menu-item>
                                <a @click="loginOut">退出登陆</a>
                            </a-menu-item>
                        </a-menu>
                    </template>
                </a-dropdown>
            </div>

        </a-layout-header>
        <a-layout>
            <a-layout-sider width="240px">
                <SiderMenu />
            </a-layout-sider>
            <a-layout-content class="content">
                <div class="tags">
                    <NavTags />
                </div>
                <div class="views">
                    <router-view v-slot="{ Component, route }">
                        <keep-alive>
                            <component :is="Component" v-if="route.meta.keepAlive" :key="route.path" />
                        </keep-alive>
                        <component :is="Component" v-if="!route.meta.keepAlive" />
                    </router-view>
                </div>
            </a-layout-content>
        </a-layout>
    </a-layout>
</template>
<style lang="scss" scoped>
.content {
    display: flex;
    flex-direction: column;

    .tags {
        margin: 10px 10px 0 10px;
    }

    .views {
        flex: 1;
        display: flex;
        flex-direction: column;
    }
}
.ant-layout-header{
    padding: 0 20px;
}
</style>
