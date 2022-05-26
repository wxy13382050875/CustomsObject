<script setup lang="ts">
    import { useStore } from "@/store";
    import { useRoute, useRouter } from "vue-router";
    const route = useRoute();
    const router = useRouter();
    const store = useStore();
    defineProps({
        title: {
            type: String,
            default: "标题"
        }
    });
    const handleBack = () => {
        store.dispatch("tabs/deleteTabs", { path: route.path, title: "", query: {}, params: {} });
        router.go(-1);
    };
    const refresh = () => {
        store.state.tabs.refresh = true;
        store.dispatch("tabs/deleteTabs", { path: route.path, title: "", query: {}, params: {} });
        router.go(-1);
    };
    defineExpose({
        refresh
    });
</script>
<template>
    <a-page-header :title="title" @back="handleBack"></a-page-header>
    <div class="content">
        <div class="wrapper">
            <slot></slot>
        </div>
    </div>
</template>
<style lang="scss" scoped>
    .content {
        flex: 1;
        position: relative;
        .wrapper {
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            overflow-x: auto;
            margin: 0 20px 20px;
            padding: 20px;
            background-color: #fff;
            border-radius: 4px;
        }
    }
</style>
