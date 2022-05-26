<script setup lang="ts">
    import { ref } from "vue";
    import { useRouter } from "vue-router";
    import { MailOutlined } from "@ant-design/icons-vue";
    import { MenuList } from "@/data/permission";
    const router = useRouter();

    const current = ref<string[]>(["mail"]);

    const handleMenuClick = ({ key }: { key: string }) => {
        router.push(key);
    };

    const handleOpenChange = (openKeys: string[]) => {
        console.log(openKeys);
    };
</script>
<template>
    <a-menu
        v-model:selectedKeys="current"
        theme="dark"
        mode="inline"
        @open-change="handleOpenChange"
        @click="handleMenuClick"
    >
        <template v-for="item in MenuList" :key="item.url">
            <template v-if="item.children.length === 0">
                <a-menu-item :key="item.url">
                    <template #icon>
                        <MailOutlined />
                    </template>
                    {{ item.name }}
                </a-menu-item>
            </template>
            <template v-else>
                <a-sub-menu :key="item.url">
                    <template #icon><MailOutlined /> </template>
                    <template #title>{{ item.name }}</template>
                    <a-menu-item v-for="child in item.children" :key="child.url">{{
                        child.name
                    }}</a-menu-item>
                </a-sub-menu>
            </template>
        </template>
    </a-menu>
</template>
