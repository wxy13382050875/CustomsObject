<script setup lang="ts">
    //机构tree
    import { ref } from "vue";
    import { orgList } from "@/api/org";

    const orgTreeData = ref<any>([]);

    const getDataTree = (appId: string) => {
        orgList(appId).then((res) => {
            orgTreeData.value = res;
        });
    };

    const emits = defineEmits(["change"]);

    //暴露方法
    defineExpose({
        getDataTree
    });
    //监听机构树被点击选中
    const handleOrgTreeSelect = (selectKeys: number[], { node }: any) => {
        emits("change", { ids: selectKeys, node: node });
    };
</script>
<script lang="ts">
    export default {
        name: "OrgTree"
    };
</script>
<template>
    <a-tree
        :tree-data="orgTreeData"
        :field-names="{ title: 'name', key: 'id' }"
        @select="handleOrgTreeSelect"
    ></a-tree>
</template>
