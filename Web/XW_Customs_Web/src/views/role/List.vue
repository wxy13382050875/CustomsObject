<script setup lang="ts">
    import { nextTick, ref, reactive } from "vue";
    import { useRouter } from "vue-router";
    import { message, Form } from "ant-design-vue";
    import { orgList, roleOfOrgList } from "@/api/org";
    import { addRole, updateRole, getRolePermission, saveRoleForPermission } from "@/api/role";

    const router = useRouter();
    const useForm = Form.useForm;
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
        },
        {
            title: "操作",
            width: "250px",
            fixed: "right",
            dataIndex: "operation"
        }
    ];
    const queryParams = ref({
        appId: ""
    });
    //表单对象
    const formState = ref({
        id: 0,
        appId: "",
        orgId: 0,
        name: "",
        code: "",
        type: "ORG",
        note: "",
        enabled: true
    });
    //表单校验规则
    const rules = reactive({
        name: [{ type: "string" as const, required: true, message: "请输入角色名称!" }],
        code: [{ type: "string" as const, required: true, message: "请输入角色编码!" }],
        note: [{ type: "string" as const, required: true, message: "请输入备注!" }]
    });
    //表格高度
    const tableHeight = ref(0);
    //表格ref对象
    const contentRef = ref();
    //机构树数据
    const orgTreeData = ref([]);
    //存储机构树点击时的数据
    const selectData = ref<any>({});
    const selectIds = ref<number[]>([]);
    //表格数据
    const tableData = ref([]);
    const { validate, resetFields, validateInfos } = useForm(formState, rules);

    //监听机构树被点击选中
    const handleOrgTreeSelect = (selectKeys: number[], { node }: any) => {
        if (selectKeys.length === 0) {
            selectData.value = {};
            tableData.value = [];
            selectIds.value = [];
            return;
        }
        selectIds.value = selectKeys;
        selectData.value = node;
        getRoleData();
    };
    nextTick(() => {
        tableHeight.value = contentRef.value.offsetHeight;
    });
    //获取机构下的角色列表
    const getRoleData = () => {
        roleOfOrgList(selectIds.value[0]).then((res: any) => {
            tableData.value = res;
        });
    };
    const roleModalStatus = ref(false);
    const roleConfirmLoading = ref(false);
    //添加角色
    const handleAddRole = () => {
        if (selectIds.value.length === 0) {
            message.info("请在左侧选择机构，再操作");
            return;
        }
        resetFields();
        formState.value.appId = queryParams.value.appId;
        formState.value.orgId = selectIds.value[0];
        roleModalStatus.value = true;
    };
    //编辑角色
    const handleEdit = (item: any) => {
        formState.value = { ...item };
        roleModalStatus.value = true;
    };
    // 重置表单
    const handleReset = () => {
        formState.value = {
            id: 0,
            appId: "",
            orgId: 0,
            name: "",
            code: "",
            type: "",
            note: "",
            enabled: true
        };
    };
    //提交添加角色
    const handleSubmitRole = () => {
        validate().then(() => {
            roleConfirmLoading.value = true;
            if (formState.value.id === 0) {
                addRole(formState.value)
                    .then(() => {
                        message.success("添加成功");
                        roleModalStatus.value = false;
                        getRoleData();
                    })
                    .finally(() => {
                        roleConfirmLoading.value = false;
                    });
            } else {
                updateRole(formState.value)
                    .then(() => {
                        message.success("更新成功");
                        roleModalStatus.value = false;
                        getRoleData();
                    })
                    .finally(() => {
                        roleConfirmLoading.value = false;
                    });
            }
        });
    };

    // 分配权限
    //选中的节点
    const permissionCheckedKeys = ref<number[]>([]);
    //第一次就展开所有节点
    const expandedKeys = ref<number[]>([]);
    //当前选择的角色数据
    const selectRoleId = ref<number | undefined>();
    const permissionTreeData = ref<any>([]);
    const authPermissionStatus = ref(false);
    const confirmAuthPermissionLoading = ref(false);
    const handleSubmitPermissionAuth = () => {
        if (permissionCheckedKeys.value.length === 0) {
            message.info("请选择权限");
            return;
        }
        confirmAuthPermissionLoading.value = true;
        saveRoleForPermission(selectRoleId.value as number, permissionCheckedKeys.value)
            .then(() => {
                message.success("权限分配成功");
                authPermissionStatus.value = false;
            })
            .finally(() => {
                confirmAuthPermissionLoading.value = false;
            });
    };
    //处理数据
    const iterateTreeDataPermission = (data: any[]) => {
        data.forEach((item) => {
            item.key = item.id;
            expandedKeys.value.push(item.id);
            if (item.checked) {
                permissionCheckedKeys.value?.push(item.id);
            }
            if (item.children.length > 0) {
                iterateTreeDataPermission(item.children);
            }
        });
    };
    const handleShowPermission = (item: any) => {
        selectRoleId.value = item.id;

        getRolePermission(item.id, { type: "WEB" }).then((res: any) => {
            permissionCheckedKeys.value = [];
            iterateTreeDataPermission(res);
            permissionTreeData.value = res;
            authPermissionStatus.value = true;
        });
    };
    //监听复选框
    const handleTreeCheck = (keys: number[]) => {
        permissionCheckedKeys.value = keys;
    };

    const getDataOrg = () => {
        if (!queryParams.value.appId) {
            message.info("请选择应用再查询");
            return;
        }
        //获取机构树数据
        orgList(queryParams.value.appId).then((res: any) => {
            orgTreeData.value = res;
        });
    };
</script>
<template>
    <ListContainer>
        <template #form>
            <a-form ref="formRef" :colon="false" :model="queryParams">
                <a-row :gutter="20">
                    <a-col :span="6">
                        <a-form-item label="所属应用" name="appId">
                            <AppSelect v-model:value="queryParams.appId" />
                        </a-form-item>
                    </a-col>
                    <a-col :span="6">
                        <a-space align="end">
                            <a-button type="primary" @click="getDataOrg">
                                <search-outlined />
                                <span>查询</span>
                            </a-button>
                        </a-space>
                    </a-col>
                </a-row>
            </a-form>
        </template>
        <a-row :gutter="18" class="h-full">
            <a-col :span="6">
                <a-card
                    class="h-full custom-card"
                    :body-style="{ position: 'relative' }"
                    :bordered="false"
                    type="inner"
                >
                    <template #title>
                        <apartment-outlined />
                        <span>机构组织</span>
                    </template>
                    <div class="content">
                        <a-tree
                            :tree-data="orgTreeData"
                            :field-names="{ title: 'name', key: 'id' }"
                            @select="handleOrgTreeSelect"
                        ></a-tree>
                    </div>
                </a-card>
            </a-col>
            <a-col :span="18">
                <a-card
                    class="h-full custom-card"
                    :bordered="false"
                    :body-style="{ padding: 0 }"
                    type="inner"
                >
                    <template #title>
                        <cluster-outlined />
                        <span>角色列表</span>
                    </template>
                    <template #extra>
                        <a href="#" @click="handleAddRole">添加角色</a>
                    </template>
                    <div ref="contentRef" class="h-full">
                        <a-table
                            bordered
                            size="small"
                            :pagination="false"
                            :data-source="tableData"
                            :scroll="{ y: tableHeight - 40 }"
                            :columns="columns"
                        >
                            <template #bodyCell="{ column, record }">
                                <template v-if="column.dataIndex === 'operation'">
                                    <a-space :gutter="8">
                                        <a-button
                                            size="small"
                                            type="primary"
                                            @click="handleShowPermission(record)"
                                            >分配权限</a-button
                                        >
                                        <a-button
                                            size="small"
                                            type="ghost"
                                            @click="handleEdit(record)"
                                            >编辑</a-button
                                        >
                                    </a-space>
                                </template>
                            </template>
                        </a-table>
                    </div>
                </a-card>
            </a-col>
        </a-row>
        <a-modal
            v-model:visible="roleModalStatus"
            centered
            :after-close="handleReset"
            width="620px"
            :confirm-loading="roleConfirmLoading"
            :body-style="{ overflowY: 'auto' }"
            :title="formState.id === 0 ? '添加角色' : '编辑角色'"
            @ok="handleSubmitRole"
        >
            <a-form :model="formState" :label-col="{ span: 4 }">
                <a-form-item label="所属机构">
                    {{ selectData.name }}
                </a-form-item>
                <a-form-item label="角色名称" v-bind="validateInfos.name">
                    <a-input v-model:value="formState.name"></a-input>
                </a-form-item>
                <a-form-item label="角色编码" v-bind="validateInfos.code">
                    <a-input v-model:value="formState.code"></a-input>
                </a-form-item>
                <a-form-item label="备注" v-bind="validateInfos.note">
                    <a-input v-model:value="formState.note"></a-input>
                </a-form-item>
            </a-form>
        </a-modal>
        <a-modal
            v-model:visible="authPermissionStatus"
            title="分配权限"
            centered
            width="620px"
            :confirm-loading="confirmAuthPermissionLoading"
            :body-style="{ height: '620px', overflowY: 'auto' }"
            :mask-closable="false"
            @ok="handleSubmitPermissionAuth"
        >
            <a-tree
                v-model:checkedKeys="permissionCheckedKeys"
                v-model:expandedKeys="expandedKeys"
                show-line
                checkable
                :field-names="{ title: 'name', key: 'id' }"
                :tree-data="permissionTreeData"
                @check="handleTreeCheck"
            >
                <template #title="{ name }">
                    {{ name }}
                </template>
            </a-tree>
            <div class="custom-empty-wrapper">
                <a-empty
                    v-show="permissionTreeData.length === 0"
                    description="该机构未分配任何权限"
                >
                    <a-button
                        type="primary"
                        @click="
                            () => {
                                authPermissionStatus = false;
                                router.push('/org');
                            }
                        "
                        >给机构分配权限</a-button
                    >
                </a-empty>
            </div>
        </a-modal>
    </ListContainer>
</template>
<style lang="scss" scoped></style>
