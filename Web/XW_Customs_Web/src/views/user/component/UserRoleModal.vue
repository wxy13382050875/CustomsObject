<script setup lang="ts">
    import { computed, ref, unref } from "vue";
    import { message } from "ant-design-vue";
    import { userRoleList, userAssigningRole } from "@/api/user";

    const columns = [
        {
            title: "角色名称",
            dataIndex: "name",
            key: "name"
        },
        {
            title: "角色编码",
            dataIndex: "code",
            key: "code"
        },
        {
            title: "状态",
            dataIndex: "enabled",
            key: "enabled"
        },
        {
            title: "备注",
            dataIndex: "note",
            key: "note"
        }
    ];
    let userId = 0;
    const tableData = ref<any>([]);
    const visible = ref<boolean>(false);
    const getData = (id: number) => {
        userId = id;
        userRoleList(userId).then((res: any) => {
            tableData.value = res;
            selectedRowKeys.value = res
                .filter((item: any) => item.check)
                .map((item: any) => {
                    return item.id;
                });
        });
    };

    const show = () => {
        visible.value = true;
    };

    const selectedRowKeys = ref<number[]>([]);
    const confirmLoading = ref<boolean>(false);
    const rowSelection = computed(() => {
        return {
            selectedRowKeys: unref(selectedRowKeys.value),
            onChange: onSelectChange
        };
    });
    const onSelectChange = (changableRowKeys: number[]) => {
        selectedRowKeys.value = changableRowKeys;
    };
    const handleSubmit = () => {
        if (selectedRowKeys.value.length === 0) {
            message.info("请选择角色");
            return;
        }
        confirmLoading.value = true;
        userAssigningRole(userId, selectedRowKeys.value)
            .then(() => {
                message.success("给用户分配角色成功");
                selectedRowKeys.value = [];
                visible.value = false;
            })
            .finally(() => {
                confirmLoading.value = false;
            });
    };
    defineExpose({
        getData,
        show
    });
</script>
<template>
    <a-modal
        v-model:visible="visible"
        title="分配角色"
        width="1000px"
        centered
        :body-style="{ padding: 0 }"
        :confirm-loading="confirmLoading"
        @ok="handleSubmit"
    >
        <a-table
            :row-selection="rowSelection"
            :row-key="(record: any) => record.id"
            size="small"
            :columns="columns"
            :pagination="false"
            :data-source="tableData"
            :scroll="{ y: 420 + 'px' }"
        ></a-table>
    </a-modal>
</template>
