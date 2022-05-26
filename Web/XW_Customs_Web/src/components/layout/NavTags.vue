<script setup lang="ts">
    import { watch, ref } from "vue";
    import { LocationQueryRaw, RouteParamsRaw, useRoute, useRouter } from "vue-router";
    import { useStore } from "@/store";
    import { TabsState } from "@/store/modules/tabs";

    const store = useStore();
    const router = useRouter();
    const route = useRoute();

    const activeKey = ref(route.path);
    const nav = ref<TabsState>({ tabList: store.getters["tabs/getTabs"] });
    //监听导航数据变化
    watch(store.state.tabs.tabList, (val) => {
        nav.value.tabList = val;
    });
    //监听路由变化
    watch(route, (val) => {
        activeKey.value = val.path;
    });
    //监听导航tab切换
    const handleNavTabsClick = (path: string) => {
        //从tab导航列表匹配出当前被点击的对象
        const rs = nav.value.tabList.filter((item) => item.path === path)[0];
        //跳转页面
        router.push({
            path: path,
            query: rs.query as LocationQueryRaw,
            params: rs.params as RouteParamsRaw
        });
    };
    //监听导航tab编辑
    const handleNavTabEdit = (targetKey: string, action: string) => {
        if (action === "remove") {
            const rs = nav.value.tabList.filter((item) => item.path === targetKey)[0];
            store.dispatch("tabs/deleteTabs", rs);
            const lastView = nav.value.tabList.slice(-1)[0];
            router.push({
                path: lastView.path,
                query: lastView.query,
                params: lastView as RouteParamsRaw
            });
        }
    };
</script>
<template>
    <a-tabs
        v-model:activeKey="activeKey"
        type="editable-card"
        hide-add
        @tab-click="handleNavTabsClick"
        @edit="handleNavTabEdit"
    >
        <a-tab-pane v-for="pane in nav.tabList" :key="pane.path" :tab="pane.title"> </a-tab-pane>
    </a-tabs>
</template>
<style lang="scss" scoped>
    :deep(.ant-tabs-nav) {
        margin: 0 !important;
    }
    // :deep(.ant-tabs-content-holder) {
    //     display: none;
    // }
</style>
