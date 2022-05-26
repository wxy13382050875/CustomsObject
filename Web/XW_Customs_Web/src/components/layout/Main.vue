<script setup lang="ts">
    import SiderMenu from "./SiderMenu.vue";
    import NavTags from "./NavTags.vue";
</script>
<template>
    <a-layout>
        <a-layout-header> </a-layout-header>
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
                            <component
                                :is="Component"
                                v-if="route.meta.keepAlive"
                                :key="route.path"
                            />
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
</style>
