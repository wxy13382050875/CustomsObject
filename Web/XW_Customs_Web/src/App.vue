<script setup lang="ts">
    import zhCN from "ant-design-vue/es/locale/zh_CN";
    const getPopupContainer = (el: unknown, dialogContext: any) => {
        if (dialogContext) {
            return dialogContext.getDialogWrap();
        } else {
            return document.body;
        }
    };
</script>

<template>
    <a-config-provider
        component-size="samll"
        :locale="zhCN"
        :get-popup-container="getPopupContainer"
    >
        <router-view />
    </a-config-provider>
</template>

<style lang="scss">
    #app,
    .ant-layout {
        height: 100vh;
    }
    .text-align-right {
        text-align: right;
    }
    .text-align-right {
        text-align: center;
    }
    .h-full {
        height: 100%;
    }
    .custom-empty-wrapper {
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .custom-card {
        display: flex;
        flex-direction: column;
        .ant-card-body {
            flex: 1;
            .content {
                padding: 16px;
                position: absolute;
                top: 2px;
                right: 0;
                bottom: 0;
                left: 0;
                overflow-y: scroll;
            }
        }
    }
</style>
